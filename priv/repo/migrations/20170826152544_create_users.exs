defmodule Flourish.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, null: false
      add :first_name, :string, null: false
      add :last_name, :string, null: false
      add :encrypted_password, :string, null: false
      add :confirmation_token, :string
      add :confirmed_at, :naive_datetime
      add :reset_password_token, :string

      timestamps()
    end

    create unique_index(:users, [:email])
    create unique_index(:users, [:confirmation_token])
    create unique_index(:users, [:reset_password_token])
  end
end
