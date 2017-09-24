defmodule FlourishWeb.PageControllerTest do
  use FlourishWeb.ConnCase
  import Fixtures.Accounts

  describe "GET /" do
    test "it is welcoming!", %{conn: conn} do
      assert(root_html(conn) =~ "Welcome to Flourish")
    end
  end

  describe "GET / while logged in" do
    setup [:create_user, :log_in_user]

    test "it allows a user to log out", %{conn: conn} do
      assert(root_html(conn) =~ "Log out")
    end
  end

  defp root_html(conn) do
    conn
    |> get("/")
    |> html_response(200)
  end

  defp create_user(context) do
    Map.put(context, :user, user_fixture())
  end

  defp log_in_user(context) do
    Flourish.Authentication.Plug.sign_in(context.conn, context.user)
    context
  end
end
