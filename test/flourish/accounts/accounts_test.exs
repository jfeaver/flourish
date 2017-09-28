defmodule Flourish.AccountsTest do
  use Flourish.DataCase
  import Fixtures.Accounts

  alias Flourish.Accounts
  alias Flourish.Accounts.{User, EmailLogin}

  @invalid_attrs %{first_name: nil, last_name: nil}

  @email email_login_attr(:email)
  @password email_login_attr(:password)

  describe "users" do
    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(user_attrs())
      assert user.first_name == "Nathan"
      assert user.last_name == "Feaver"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "create_login/4 for email creates a new EmailLogin" do
      user = user_fixture()
      assert {:ok, %EmailLogin{} = email_login} = Accounts.create_login(user, :email, @email, @password)
      assert email_login.email == @email
      assert Comeonin.Bcrypt.checkpw(@password, email_login.encrypted_password)
    end

    test "create_login/4 for email downcases the email" do
      user = user_fixture()
      assert {:ok, %EmailLogin{} = email_login} = Accounts.create_login(user, :email, String.capitalize(@email), @password)
      assert email_login.email == String.downcase(@email)
    end

    test "get_user_by/2 email fails to find a user who doesn't exist" do
      result = Accounts.get_user_by(:email, @email)
      assert result == nil
    end
  end


  describe "an existing user" do
    setup [:create_user_with_email_login]

    test "login/3 for email returns successfully if the email/password is correct", context do
      {status, authenticated} = Accounts.login(:email, @email, @password)
      assert status == :ok
      assert authenticated.id == context.user.id
    end

    test "login/3 for email returns successfully if the email is capitalized", context do
      {status, authenticated} = Accounts.login(:email, String.capitalize(@email), @password)
      assert status == :ok
      assert authenticated.id == context.user.id
    end

    test "login/3 for email returns an error if the password is incorrect" do
      {status, reason} = Accounts.login(:email, @email, "otherPassword")
      assert status == :error
      assert reason == :missing_login
    end

    test "login/3 for email returns an error if the email is incorrect" do
      {status, reason} = Accounts.login(:email, "otherEmail@mail.com", @password)
      assert status == :error
      assert reason == :missing_login
    end

    test "get_user_by/2 email finds a user with an email login", context do
      result = Accounts.get_user_by(:email, @email)
      assert result.id == context.user.id
    end

    def create_user_with_email_login(context) do
      user = user_fixture()
      email_login_fixture(user)
      Map.put(context, :user, user)
    end
  end
end
