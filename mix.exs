defmodule DisposableEmail.MixProject do
  use Mix.Project

  def project do
    [
      app: :disposable_email,
      version: "0.4.2",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      description:
        "Detect disposable and temporary email addresses by checking domains against a regularly updated list from the disposable-email-domains repository.",
      source_url: "https://github.com/oshanz/disposable-email"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {DisposableEmail.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:briefly, "~> 0.5.1"},
      {:tesla, "~> 1.11"},
      {:mint, "~> 1.0"},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

  defp package do
    [
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => "https://github.com/oshanz/disposable-email"}
    ]
  end
end
