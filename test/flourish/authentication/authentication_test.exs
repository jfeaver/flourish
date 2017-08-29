defmodule Flourish.AuthenticationTest do
  # use Flourish.DataCase
  use ExUnit.Case

  alias Flourish.Authentication

  def password, do: "password"
  def attributes, do: %{password: password()}

  describe "attributes" do
    test "encrypt_attributes/1 replaces the password attribute with an encrypted_password attribute" do
      attrs = Authentication.encrypt_attributes(attributes())
      refute Map.has_key?(attrs, :password)
      assert Map.has_key?(attrs, :encrypted_password)
    end

    test "encrypt_attributes/1 encrypts the password given" do
      attrs = Authentication.encrypt_attributes(attributes())
      refute attrs.encrypted_password == password()
    end
  end

  describe "passwords" do
    test "authenticate_password/1 should verify a password is correct" do
      stored_attributes = Authentication.encrypt_attributes(attributes())
      {:ok, ^stored_attributes} = Authentication.authenticate_password(stored_attributes, password())
    end

    test "authenticate_password/1 should detect an invalid password" do
      stored_attributes = Authentication.encrypt_attributes(attributes())
      {:error, message} = Authentication.authenticate_password(stored_attributes, "other password")
      assert "invalid password" = message
    end
  end
end
