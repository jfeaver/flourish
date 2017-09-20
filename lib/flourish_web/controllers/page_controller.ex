defmodule FlourishWeb.PageController do
  use FlourishWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def welcome(conn, _params) do
    render conn, "welcome.html"
  end
end
