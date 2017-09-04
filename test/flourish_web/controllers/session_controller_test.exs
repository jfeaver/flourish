defmodule FlourishWeb.SessionControllerTest do
  use FlourishWeb.ConnCase
  import Fixtures.Accounts

  @email email_login_attr(:email)
  @password email_login_attr(:password)
  @email_login_params %{"email_login" => %{"email" => @email, "password" => @password}}

  setup do
    user = user_fixture()
    email_login = email_login_fixture(user)
    [user: user]
  end

  describe "create/2" do
    test "logs the user in", context do
      response = post(build_conn(), "/sessions", @email_login_params)
      assert(Guardian.Plug.current_resource(response).id == context[:user].id)
    end

    test "the logged in user persists to a second request", context do
      post(build_conn(), "/sessions", @email_login_params)
      response = get(build_conn(), "/")
      assert(Guardian.Plug.current_resource(response).id == context[:user].id)
    end
  end
end
