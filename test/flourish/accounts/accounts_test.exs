defmodule Flourish.AccountsTest do
  use Flourish.DataCase
  import Fixtures.Accounts

  alias Flourish.Accounts

  describe "users" do
    alias Flourish.Accounts.{User, EmailLogin}

    @invalid_attrs %{first_name: nil, last_name: nil}

    @email email_login_attr(:email)
    @password email_login_attr(:password)

    # test "get_user!/1 returns the user with given id" do
    #   user = user_fixture()
    #   assert Accounts.get_user!(user.id) == user
    # end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(user_attrs)
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

    test "login/3 for email returns successfully if the email/password is correct" do
      user = user_fixture()
      email_login_fixture(user)
      {status, authenticated} = Accounts.login(:email, @email, @password)
      assert status == :ok
      assert authenticated.id == user.id
    end

    test "login/3 for email returns an error if the password is incorrect" do
      user = user_fixture()
      email_login_fixture(user)
      {status, reason} = Accounts.login(:email, @email, "otherPassword")
      assert status == :error
      assert reason == :missing_login
    end

    test "login/3 for email returns an error if the email is incorrect" do
      user = user_fixture()
      email_login_fixture(user)
      {status, reason} = Accounts.login(:email, "otherEmail@mail.com", @password)
      assert status == :error
      assert reason == :missing_login
    end

    test "get_user_by/2 email finds a user with an email login" do
      user = user_fixture()
      email_login_fixture(user)
      result = Accounts.get_user_by(:email, @email)
      assert result.id == user.id
    end

    test "get_user_by/2 email fails to find a user who doesn't exist" do
      result = Accounts.get_user_by(:email, @email)
      assert result == nil
    end

    # test "update_user/2 with valid data updates the user" do
    #   user = user_fixture()
    #   assert {:ok, user} = Accounts.update_user(user, @update_attrs)
    #   assert %User{} = user
    #   assert user.first_name == "some updated first_name"
    #   assert user.last_name == "some updated last_name"
    # end

    # test "update_user/2 with invalid data returns error changeset" do
    #   user = user_fixture()
    #   assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
    #   assert user == Accounts.get_user!(user.id)
    # end

    # test "delete_user/1 deletes the user" do
    #   user = user_fixture()
    #   assert {:ok, %User{}} = Accounts.delete_user(user)
    #   assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    # end

    # test "change_user/1 returns a user changeset" do
    #   user = user_fixture()
    #   assert %Ecto.Changeset{} = Accounts.change_user(user)
    # end
  end
end
