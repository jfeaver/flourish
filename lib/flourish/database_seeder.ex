defmodule Flourish.DatabaseSeeder do
  def insert_nathan do
    Flourish.Repo.insert!(%Flourish.Accounts.User{first_name: "Nathan", last_name: "Feaver"})
    %{password_hash: encrypted_password} = Comeonin.Bcrypt.add_hash("password")
    Flourish.Repo.insert!(%Flourish.Accounts.EmailLogin{email: "nathan@mail.com", encrypted_password: encrypted_password})
  end
end
