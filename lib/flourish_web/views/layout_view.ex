defmodule FlourishWeb.LayoutView do
  use FlourishWeb, :view

  def current_user(conn) do
    Flourish.Authentication.Plug.current_resource(conn)
  end
end
