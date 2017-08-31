defmodule Flourish.AccountsTest do
  use Flourish.DataCase

  alias Flourish.Accounts

  describe "users" do
    alias Flourish.Accounts.{User, EmailLogin}

    @valid_attrs %{first_name: "Nathan", last_name: "Feaver"}
    # @update_attrs %{first_name: "Jonathan", last_name: "Feavre"}
    @invalid_attrs %{first_name: nil, last_name: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    # test "get_user!/1 returns the user with given id" do
    #   user = user_fixture()
    #   assert Accounts.get_user!(user.id) == user
    # end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.first_name == "Nathan"
      assert user.last_name == "Feaver"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "create_login/4 for email creates a new EmailLogin" do
      user = user_fixture()
      password = "password"
      assert {:ok, %EmailLogin{} = email_login} = Accounts.create_login(user, :email, "nathan@mail.com", password)
      assert email_login.email == "nathan@mail.com"
      assert Comeonin.Bcrypt.checkpw(password, email_login.encrypted_password)
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
