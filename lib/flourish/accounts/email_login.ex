defmodule Flourish.Accounts.EmailLogin do
  use Ecto.Schema
  import Ecto.Changeset
  alias Flourish.Accounts.{EmailLogin, User}


  schema "email_logins" do
    belongs_to :user, User
    field :email, :string
    field :encrypted_password, :string

    timestamps()
  end

  @doc false
  def changeset(%EmailLogin{} = email_login, attrs) do
    email_login
    |> cast(attrs, [:email, :encrypted_password])
    |> put_assoc(:user, attrs.user)
    |> validate_required([:email, :encrypted_password, :user])
  end
end
