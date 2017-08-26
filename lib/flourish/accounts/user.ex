defmodule Flourish.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Flourish.Accounts.User


  schema "users" do
    field :confirmation_token, :string
    field :confirmed_at, :naive_datetime
    field :email, :string
    field :encrypted_password, :string
    field :first_name, :string
    field :last_name, :string
    field :reset_password_token, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :first_name, :last_name, :encrypted_password, :confirmation_token, :confirmed_at, :reset_password_token])
    |> validate_required([:email, :first_name, :last_name, :encrypted_password])
  end
end
