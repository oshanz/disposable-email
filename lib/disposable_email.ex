defmodule DisposableEmail do
  use GenServer

  @source "https://github.com/disposable-email-domains/disposable-email-domains/raw/refs/heads/main/disposable_email_blocklist.conf"

  def start_link(_init_arg) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def is_disposable?(email) do
    GenServer.call(__MODULE__, {:check, email})
  end

  def reload do
    GenServer.cast(__MODULE__, {:reload})
  end

  def blocklist_size do
    GenServer.call(__MODULE__, {:store_size})
  end

  @impl true
  def init(_init_arg) do
    delete_table()
    :ets.new(__MODULE__, [:named_table, :private, :bag])
    {:ok, nil, {:continue, :init}}
  end

  @impl true
  def handle_continue(:init, state) do
    refill_store("disposable_email_blocklist.conf")
    {:noreply, state}
  end

  @impl true
  def terminate(_reason, _state) do
    delete_table()
    Briefly.cleanup()
  end

  @impl true
  def handle_call({:check, email}, _from, state) do
    suffix = email |> String.split("@") |> List.last()
    exists = :ets.lookup(__MODULE__, suffix) |> length() > 0
    {:reply, exists, state}
  end

  @impl true
  def handle_call({:store_size}, _from, state) do
    size = :ets.info(__MODULE__, :size)
    {:reply, size, state}
  end

  @impl true
  def handle_cast({:reload}, state) do
    {:ok, path} = download_blocklist()
    refill_store(path)

    {:noreply, state}
  end

  defp refill_store(path) do
    File.stream!(path)
    |> Stream.map(&String.trim/1)
    |> Stream.each(fn line ->
      :ets.insert(__MODULE__, {line})
    end)
    |> Stream.run()
  end

  defp delete_table do
    case :ets.whereis(__MODULE__) do
      :undefined -> :already_deleted
      _ -> :ets.delete(__MODULE__)
    end
  end

  defp download_blocklist do
    {:ok, path} = Briefly.create()
    {:ok, responce} = Tesla.get(client(), @source)

    responce.body
    |> Stream.each(fn chunk ->
      File.write(path, chunk)
    end)
    |> Stream.run()

    {:ok, path}
  end

  defp client do
    Tesla.client(
      [
        {Tesla.Middleware.FollowRedirects, max_redirects: 2}
      ],
      {Tesla.Adapter.Mint, body_as: :stream}
    )
  end
end
