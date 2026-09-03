# DisposableEmail

 Prevent fake signups and spam: Elixir library for detecting disposable and temporary emails, using an up-to-date blocklist of over 5,000 domains.

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
If blocklist download fails, an error is logged, but the app continues running using the most recent available blocklist (bundled at startup or last successful download).

## Installation

Add `disposable_email` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:disposable_email, "~> 0.5"}
  ]
end
```

## HTTP client

By default, blocklist downloads use Erlang's built-in `:httpc` adapter, so no extra HTTP client dependency is required. To use a different [Tesla adapter](https://hexdocs.pm/tesla/readme.html#adapters) (e.g. Mint, Hackney, Finch), add its dependency to your app and configure it:

```elixir
config :disposable_email, :tesla_adapter, {Tesla.Adapter.Mint, body_as: :stream}
```

## Usage

```elixir
# Check if an email is from a disposable domain
DisposableEmail.disposable?("user@tempmail.com")
# => true

DisposableEmail.disposable?("user@gmail.com")
# => false
```

## Changelog

See [CHANGELOG.md](CHANGELOG.md)
