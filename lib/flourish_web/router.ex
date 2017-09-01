defmodule FlourishWeb.Router do
  use FlourishWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :authenticated do
    plug Guardian.Plug.EnsureAuthenticated
    plug Guardian.Plug.LoadResource
  end

  pipeline :unauthenticated do
    plug FlourishWeb.Plug.Unauthenticated
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", FlourishWeb do
    pipe_through [:browser, :unauthenticated]

    get "/", PageController, :index
    resources "/sessions", SessionController, singleton: true, only: [:create]
  end
end
