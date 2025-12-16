# DisposableEmail

A GenServer-based Elixir library for detecting disposable email addresses using the disposable-email-domains blocklist.

This library periodically downloads and caches a list of known disposable email domains, allowing you to quickly check if an email address is from a temporary email service.

## Features

- [x] Handles subdomain matching (e.g., `user@sub.domain.com`)
- [x] Fast in-memory lookup using ETS tables
- [x] Supports scheduled downloads of the latest blocklist from [github.com/disposable-email-domains](https://github.com/disposable-email-domains/disposable-email-domains)

```elixir
## https://hexdocs.pm/quantum/Quantum.html
config :my_app, MyApp.Scheduler,
  jobs: [
    {"@daily", {DisposableEmail, :reload, []}},
  ]
```

## Installation

Add `disposable_email` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:disposable_email, "~> 0.1.0"}
  ]
end
```

The `DisposableEmail` GenServer needs to be added to your application's supervision tree.

```elixir
def start(_type, _args) do
  children = [
    DisposableEmail
  ]
  opts = [strategy: :one_for_one, name: MyApp.Supervisor]
  Supervisor.start_link(children, opts)
end
```

## Usage

```elixir
# Check if an email is from a disposable domain
DisposableEmail.disposable?("user@tempmail.com")
# => true

DisposableEmail.disposable?("user@gmail.com")
# => false
```
