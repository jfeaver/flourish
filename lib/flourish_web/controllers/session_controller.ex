defmodule FlourishWeb.SessionController do
  use FlourishWeb, :controller

  def create(conn, %{"email_login" => %{"email" => email, "password" => password}}) do
    case Flourish.Accounts.login(:email, email, password) do
      {:ok, user} ->
        conn
        |> Flourish.Authentication.Plug.sign_in(user)
        |> put_flash(:info, "Welcome Back!")
        |> redirect_home
      {:error, :missing_login} ->
        conn
        |> put_flash(:error, "Unknown login")
        |> redirect_home
    end
  end

  def delete(conn, _params) do
    conn
    |> Flourish.Authentication.Plug.sign_out()
    |> redirect_home
  end

  defp redirect_home(conn) do
    redirect(conn, to: page_path(conn, :index))
  end
end
