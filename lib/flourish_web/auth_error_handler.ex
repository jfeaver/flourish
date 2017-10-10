defmodule FlourishWeb.AuthErrorHandler do
  import Phoenix.Controller

  def auth_error(conn, _info, _opts) do
    case current_path(conn, %{}) do
      "/" ->
        notify_expired(conn)
      _ ->
        notify_expired(conn)
        |> redirect(to: "/")
    end
  end

  defp notify_expired(conn) do
    conn
    |> put_flash(:info, "Your session has expired. Please log in again.")
  end
end
