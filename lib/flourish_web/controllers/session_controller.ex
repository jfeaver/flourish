defmodule FlourishWeb.SessionController do
  use FlourishWeb, :controller

  def create(conn, %{"email_login" => %{"email" => email, "password" => password}}) do
    case Flourish.Accounts.login(:email, email, password) do
      {:ok, user} ->
        conn
        |> Flourish.Authentication.Plug.sign_in(user)
        |> put_flash(:info, "Welcome Back!")
        |> redirect(to: "/")
      {:error, :missing_login} ->
        conn
        |> put_flash(:error, "Unknown login")
        |> redirect(to: "/")
    end
  end
end
