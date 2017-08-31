defmodule Flourish.Repo.Migrations.CreateEmailLogins do
  use Ecto.Migration

  def change do
    create table(:email_logins) do
      add :user_id, references(:users), null: false
      add :email, :string, null: false
      add :encrypted_password, :string, null: false

      timestamps()
    end

    create index(:email_logins, [:email], unique: true)
  end
end
