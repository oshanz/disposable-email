defmodule DisposableEmail do
  use GenServer

  @source "https://github.com/disposable-email-domains/disposable-email-domains/raw/refs/heads/main/disposable_email_blocklist.conf"

  def start_link(_arg) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def is_disposable?(email) do
    GenServer.call(__MODULE__, {:check, email})
  end

  def init(_init_arg) do
    # :ets.delete(:user_lookup)
    :ets.new(__MODULE__, [:named_table, :private, :bag, read_concurrency: true])
    {:ok, nil, {:continue, :init}}
  end

  def handle_continue(:init, _state) do
    File.stream!("disposable_email_blocklist.conf")
    |> Stream.map(&String.trim/1)
    |> Stream.each(fn line ->
      :ets.insert(__MODULE__, {line})
    end)
    |> Stream.run()

    {:noreply, nil}
  end

  def handle_call({:check, email}, _from, _state) do
    suffix = email |> String.split("@") |> List.last()
    count = :ets.lookup(__MODULE__, suffix) |> length()
    {:reply, count, nil}
  end

  def reload do
    # each day or ENV defined
  end

  def download_blocklist do
    {:ok, path} = Briefly.create()
    {:ok, responce} = Tesla.get(@source)
    responce.body |> Stream.each(fn chunk -> File.write(path, chunk) end)
    # Briefly.cleanup()
  end
end
