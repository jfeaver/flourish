defmodule FlourishWeb.Router do
  use FlourishWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers

    plug FlourishWeb.Pipeline.LoadAuthenticated
  end

  pipeline :authenticated do
    plug FlourishWeb.Pipeline.EnsureAuthenticated
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", FlourishWeb do
    pipe_through [:browser]

    get "/", PageController, :index
    resources "/sessions", SessionController, only: [:create, :delete], singleton: true
  end

  scope "/", FlourishWeb do
    pipe_through [:browser, :authenticated]
  end
end
