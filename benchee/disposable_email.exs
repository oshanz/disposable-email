Benchee.run(
  %{
    "disposable domain" => fn -> DisposableEmail.disposable?("user@tempmail.com") end,
    "valid domain" => fn -> DisposableEmail.disposable?("user@gmail.com") end,
    "nested domain" => fn -> DisposableEmail.disposable?("user@mail.tempmail.com") end
  },
  warmup: 1,
  time: 10,
  memory_time: 2,
  reduction_time: 2,
  parallel: 1,
  formatters: [
    Benchee.Formatters.Console,
    {Benchee.Formatters.Markdown, file: "benchee/benchmark.md"}
  ]
)
