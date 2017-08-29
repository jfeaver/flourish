defmodule FlourishWeb.SessionController do
  use FlourishWeb, :controller

  def create(conn, %{"user" => %{"email" => email, "password" => password}}) do
    case Flourish.Accounts.authenticate_with_email_and_password(email, password) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Welcome back!")
        |> put_session(:user_id, user.id)
        |> configure_session(renew: true)
        |> redirect(to: page_path(conn, :index))
      {:error, :unauthorized} ->
        conn
        |> put_flash(:error, "We couldn't find that email/password combination")
        |> redirect(to: page_path(conn, :index))
    end
  end
end
