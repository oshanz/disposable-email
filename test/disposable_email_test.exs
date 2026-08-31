defmodule DisposableEmailTest do
  use ExUnit.Case
  doctest DisposableEmail

  import ExUnit.CaptureLog

  test "zed.eu is blocked" do
    assert true == DisposableEmail.disposable?("dfs@z0d.eu")
  end

  test "subdomains are blocked" do
    assert true == DisposableEmail.disposable?("testmail@yopmail.com")
    assert true == DisposableEmail.disposable?("testmail@level1.yopmail.com")
    assert true == DisposableEmail.disposable?("testmail@level1.level2.yopmail.com")
  end

  test "gmail.com is allowed" do
    assert false == DisposableEmail.disposable?("dfs@gmail.com")
  end

  test "invalid email types are blocked" do
    assert false == DisposableEmail.disposable?("testmailyopmail.com")
    assert false == DisposableEmail.disposable?("testmail@yopmail")
    assert false == DisposableEmail.disposable?("testmailyopmail")
  end

  test "reload blocklist" do
    Tesla.Mock.mock_global(fn %{method: :get} ->
      %Tesla.Env{status: 200, body: ["example.com\n"]}
    end)

    size_before = DisposableEmail.blocklist_size()

    DisposableEmail.reload()

    assert DisposableEmail.blocklist_size() == size_before + 1
  end

  test "reload logs an error and keeps the existing blocklist on HTTP error" do
    Tesla.Mock.mock_global(fn %{method: :get} ->
      %Tesla.Env{status: 404, body: "Not Found"}
    end)

    size_before = DisposableEmail.blocklist_size()

    log =
      capture_log(fn ->
        DisposableEmail.reload()
        DisposableEmail.blocklist_size()
      end)

    assert log =~ "http_error"
    assert DisposableEmail.blocklist_size() == size_before
  end
end
