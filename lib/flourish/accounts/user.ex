defmodule Flourish.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Flourish.Accounts.User


  schema "users" do
    field :first_name, :string
    field :last_name, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name])
    |> validate_required([:first_name, :last_name])
  end
end
