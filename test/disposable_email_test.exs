defmodule DisposableEmailTest do
  use ExUnit.Case
  doctest DisposableEmail

  test "zed.eu is blocked" do
    assert DisposableEmail.is_disposable?("dfs@z0d.eu") == 1
  end

  test "gmail.com is allowed" do
    assert DisposableEmail.is_disposable?("dfs@gmail.com") == 0
  end
end
