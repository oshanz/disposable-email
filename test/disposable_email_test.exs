defmodule DisposableEmailTest do
  use ExUnit.Case
  doctest DisposableEmail

  test "zed.eu is blocked" do
    assert DisposableEmail.is_disposable?("dfs@z0d.eu") == true
  end

  test "gmail.com is allowed" do
    assert DisposableEmail.is_disposable?("dfs@gmail.com") == false
  end

  test "download blocklist" do
    DisposableEmail.reload()

    assert DisposableEmail.blocklist_size() > 1000
  end
end
