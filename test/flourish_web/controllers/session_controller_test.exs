defmodule FlourishWeb.SessionControllerTest do
  use FlourishWeb.ConnCase
  import Fixtures.Accounts

  @email email_login_attr(:email)
  @password email_login_attr(:password)
  @email_login_params %{"email_login" => %{"email" => @email, "password" => @password}}

  setup do
    user = user_fixture()
    email_login_fixture(user)
    [user: user]
  end

  describe "create/2" do
    test "logs the user in", %{conn: conn, user: user} do
      logged_in_id =
        conn
        |> post("/sessions", @email_login_params)
        |> Flourish.Authentication.Plug.current_resource
        |> Map.get(:id)
      assert(logged_in_id == user.id)
    end

    test "the logged in user persists to a second request", %{conn: conn, user: user} do
      response =
        conn
          |> post("/sessions", @email_login_params)
          |> get("/welcome")
      assert(Flourish.Authentication.Plug.current_resource(response).id == user.id)
    end
  end
end
