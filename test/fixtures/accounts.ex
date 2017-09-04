defmodule Fixtures.Accounts do
  alias Flourish.Accounts

  def user_attrs do
    %{first_name: "Nathan", last_name: "Feaver"}
  end

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(user_attrs)
      |> Accounts.create_user()

    user
  end

  def email_login_attrs, do: %{email: "nathan@mail.com", password: "password"}

  def email_login_fixture(user, attrs \\ %{}) do
    attrs = attrs
            |> Enum.into(email_login_attrs)
    {:ok, email_login} = Accounts.create_login(user, :email, attrs.email, attrs.password)

    email_login
  end

  def email_login_attr(attr), do: Map.fetch!(email_login_attrs, attr)
end
