defmodule Flourish.Authentication do
  def encrypt_attributes(%{password: password} = attrs) do
    %{password_hash: encrypted_password} = Comeonin.Bcrypt.add_hash(password)

    attrs
    |> Map.delete(:password)
    |> Map.put(:encrypted_password, encrypted_password)
  end

  def authenticate_password(data = %{encrypted_password: _encrypted_password}, password) do
    Comeonin.Bcrypt.check_pass(data, password)
  end
end
