defmodule FlourishWeb.AuthErrorHandler do
  import Phoenix.Controller

  def auth_error(conn, _info, _opts) do
    conn
    |> put_flash(:info, "Your session has expired. Please log in again.")
  end
end
