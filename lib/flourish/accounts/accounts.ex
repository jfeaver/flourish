defmodule Flourish.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Flourish.Repo

  alias Flourish.Accounts.{User, EmailLogin}

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def create_login(user = %User{}, :email, email, password) do
    %{password_hash: encrypted_password} = Comeonin.Bcrypt.add_hash(password)
    %EmailLogin{}
    |> EmailLogin.changeset(%{user: user, email: String.downcase(email), encrypted_password: encrypted_password})
    |> Repo.insert()
  end

  def login(:email, email, password) do
    user =
      get_user_by(:email, email)
      |> Repo.preload(:email_login)
    case user do
      %User{} ->
        case Comeonin.Bcrypt.check_pass(user.email_login, password) do
          {:ok, _email_login} -> {:ok, user}
          {:error, _message} -> {:error, :missing_login}
        end
      nil -> {:error, :missing_login}
    end
  end

  def get_user_by(:email, email) do
    email = String.downcase(email)
    query = from u in User,
              join: e in EmailLogin,
              where: e.user_id == u.id and e.email == ^email
    Repo.one(query)
  end

  # @doc """
  # Updates a user.

  # ## Examples

  #     iex> update_user(user, %{field: new_value})
  #     {:ok, %User{}}

  #     iex> update_user(user, %{field: bad_value})
  #     {:error, %Ecto.Changeset{}}

  # """
  # def update_user(%User{} = user, attrs) do
  #   user
  #   |> User.changeset(attrs)
  #   |> Repo.update()
  # end

  # @doc """
  # Deletes a User.

  # ## Examples

  #     iex> delete_user(user)
  #     {:ok, %User{}}

  #     iex> delete_user(user)
  #     {:error, %Ecto.Changeset{}}

  # """
  # def delete_user(%User{} = user) do
  #   Repo.delete(user)
  # end

  # @doc """
  # Returns an `%Ecto.Changeset{}` for tracking user changes.

  # ## Examples

  #     iex> change_user(user)
  #     %Ecto.Changeset{source: %User{}}

  # """
  # def change_user(%User{} = user) do
  #   User.changeset(user, %{})
  # end

  # defp get_user!(id), do: Repo.get!(User, id)

end
