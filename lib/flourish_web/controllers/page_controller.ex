defmodule FlourishWeb.PageController do
  use FlourishWeb, :controller

  def index(conn, _params) do
    if current_user(conn) do
      render conn, "welcome.html"
    else
      render conn, "index.html"
    end
  end
end
