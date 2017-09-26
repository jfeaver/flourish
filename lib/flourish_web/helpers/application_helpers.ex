defmodule FlourishWeb.ApplicationHelpers do
  def current_user(conn) do
    Flourish.Authentication.Plug.current_resource(conn)
  end
end
