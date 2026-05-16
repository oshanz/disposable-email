defmodule DisposableEmailTest do
  use ExUnit.Case
  doctest DisposableEmail

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

  test "download blocklist" do
    DisposableEmail.reload()

    assert DisposableEmail.blocklist_size() > 1000
  end

  describe "valid_format?/1" do
    test "accepts a standard email" do
      assert true == DisposableEmail.valid_format?("user@example.com")
    end

    test "accepts email with plus tag" do
      assert true == DisposableEmail.valid_format?("user+tag@example.org")
    end

    test "accepts email with subdomain" do
      assert true == DisposableEmail.valid_format?("user@mail.example.co.uk")
    end

    test "rejects empty string" do
      assert false == DisposableEmail.valid_format?("")
    end

    test "rejects missing @ sign" do
      assert false == DisposableEmail.valid_format?("userexample.com")
    end

    test "rejects missing local part" do
      assert false == DisposableEmail.valid_format?("@example.com")
    end

    test "rejects missing domain TLD" do
      assert false == DisposableEmail.valid_format?("user@example")
    end

    test "rejects spaces in email" do
      assert false == DisposableEmail.valid_format?("user name@example.com")
    end

    test "rejects double @" do
      assert false == DisposableEmail.valid_format?("user@@example.com")
    end
  end
end
