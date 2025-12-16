defmodule DisposableEmailTest do
  use ExUnit.Case
  doctest DisposableEmail

  test "zed.eu is blocked [deprecated]" do
    assert true == DisposableEmail.is_disposable?("dfs@z0d.eu")
  end

  test "zed.eu is blocked" do
    assert true == DisposableEmail.disposable?("dfs@z0d.eu")
  end

  test "subdomains are blocked [deprecated]" do
    assert true == DisposableEmail.is_disposable?("testmail@yopmail.com")
    assert true == DisposableEmail.is_disposable?("testmail@level1.yopmail.com")
    assert true == DisposableEmail.is_disposable?("testmail@level1.level2.yopmail.com")
  end

  test "subdomains are blocked" do
    assert true == DisposableEmail.disposable?("testmail@yopmail.com")
    assert true == DisposableEmail.disposable?("testmail@level1.yopmail.com")
    assert true == DisposableEmail.disposable?("testmail@level1.level2.yopmail.com")
  end

  test "gmail.com is allowed [deprecated]" do
    assert false == DisposableEmail.is_disposable?("dfs@gmail.com")
  end

  test "gmail.com is allowed" do
    assert false == DisposableEmail.is_disposable?("dfs@gmail.com")
  end

  test "download blocklist" do
    DisposableEmail.reload()

    assert DisposableEmail.blocklist_size() > 1000
  end
end
