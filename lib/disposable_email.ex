defmodule DisposableEmail do
  @moduledoc """
  Disposable Email Verification Service
  """
  require Logger

  use GenServer

  @source "https://raw.githubusercontent.com/disposable-email-domains/disposable-email-domains/refs/heads/main/disposable_email_blocklist.conf"

  def start_link(_init_arg) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  @deprecated "Use disposable?/1 instead"
  @spec is_disposable?(String.t()) :: boolean()
  # credo:disable-for-next-line
  def is_disposable?(email) do
    GenServer.call(__MODULE__, {:check, email})
  end

  @doc """
  Check if an email is from a disposable domain
  ```elixir
  DisposableEmail.disposable?("user@tempmail.com")
  => true

  DisposableEmail.disposable?("user@gmail.com")
  => false
  ```
  """
  @spec disposable?(String.t()) :: boolean()
  def disposable?(email) do
    GenServer.call(__MODULE__, {:check, email})
  end

  @doc """
  Reseed the blocklist from the remote repository.
  """
  @spec reload() :: :ok
  def reload do
    GenServer.cast(__MODULE__, {:reload})
  end

  @doc """
  Return the blocklist count.
  """
  @spec blocklist_size() :: non_neg_integer()
  def blocklist_size do
    GenServer.call(__MODULE__, {:store_size})
  end

  @impl true
  def init(_init_arg) do
    delete_table()
    schedule_reload()
    :ets.new(__MODULE__, [:named_table, :private, :set])
    {:ok, nil, {:continue, :init}}
  end

  @impl true
  def handle_continue(:init, state) do
    path = Application.app_dir(:disposable_email, "priv/disposable_email_blocklist.conf")
    refill_store(path)
    Logger.info("DisposableEmail initialized with #{store_size()} domains.")
    {:noreply, state}
  end

  @impl true
  def terminate(_reason, _state) do
    delete_table()
    Briefly.cleanup()
  end

  @impl true
  def handle_call({:check, email}, _from, state) do
    parts = email |> String.split("@") |> List.last() |> String.split(".")

    domain_parts =
      0..((parts |> length()) - 2)
      |> Enum.map(fn n ->
        Enum.slice(parts, n..-1//1) |> Enum.join(".")
      end)

    exists =
      domain_parts
      |> Enum.any?(fn part ->
        :ets.lookup(__MODULE__, part) |> length() > 0
      end)

    {:reply, exists, state}
  end

  @impl true
  def handle_call({:store_size}, _from, state) do
    {:reply, store_size(), state}
  end

  defp store_size do
    :ets.info(__MODULE__, :size)
  end

  @impl true
  def handle_cast({:reload}, state) do
    case download_blocklist() do
      {:ok, path} -> refill_store(path)
      {:error, reason} -> Logger.error(reason)
    end

    Logger.info("DisposableEmail reloaded with #{store_size()} domains.")
    schedule_reload()
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
    with {:ok, path} <- Briefly.create(),
         {:ok, io} <- File.open(path, [:write]),
         {:ok, response} <- Tesla.get(client(), @source) do
      response.body
      |> Stream.each(fn chunk ->
        IO.write(io, chunk)
      end)
      |> Stream.run()

      File.close(io)
      {:ok, path}
    else
      {:error, reason} -> {:error, reason}
    end
  end

  defp client do
    Tesla.client(
      [
        {Tesla.Middleware.FollowRedirects, max_redirects: 2}
      ],
      {Tesla.Adapter.Mint, body_as: :stream}
    )
  end

  defp schedule_reload do
    Application.get_env(:disposable_email, :reload_in_days, 7) |> schedule_reload()
  end

  defp schedule_reload(in_days) when is_integer(in_days) and in_days > 0 do
    time = :timer.seconds(24 * in_days)
    Process.send_after(self(), :reload, time)
    Logger.debug("DisposableEmail is scheduled to reload in #{in_days} days")
  end

  defp schedule_reload(_) do
    Logger.debug("DisposableEmail scheduled reload disabled")
  end

  @impl true
  def handle_info(:reload, state) do
    GenServer.cast(__MODULE__, {:reload})
    {:noreply, state}
  end
end
