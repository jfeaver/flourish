defmodule FlourishWeb.AuthErrorHandler do
  import Phoenix.Controller
  import Plug.Conn, only: [halt: 1, send_resp: 3]

  def auth_error(conn, {:invalid_token, :token_expired}, _opts) do
    conn
    |> put_flash(:info, "Your session has expired. Please log in again.")
  end

  def auth_error(conn, {:unauthenticated, :unauthenticated}, _opts) do
    # TODO: save the page for redirect after sign in!
    conn
    |> put_flash(:info, "You need to sign in to view this page")
    |> put_view(FlourishWeb.ErrorView)
    |> render("401.html")
    |> halt
  end

  def auth_error(conn, {type, _reason}, _opts) do
    body = Poison.encode!(%{message: to_string(type)})
    send_resp(conn, 401, body)
  end
end
