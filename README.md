# DisposableEmail


## Features

* Supports scheduled downloads of the blocklist from [github.com/disposable-email-domains](https://github.com/disposable-email-domains/disposable-email-domains)

```elixir
## https://hexdocs.pm/quantum/Quantum.html
config :my_app, MyApp.Scheduler,
  jobs: [
    {"@daily", {DisposableEmail, :reload, []}},
  ]
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `disposable_email` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:disposable_email, "~> 0.1.0"}
  ]
end
```

## Usage

```elixir
boolean_result = DisposableEmail.is_disposable?("disposable@z0d.eu")
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/disposable_email>.
