defmodule FlourishWeb.Router do
  use FlourishWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers

    plug Flourish.Authentication.LoadResource
  end

  pipeline :authenticated do
    plug Flourish.Authentication.EnsureAuthenticated
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", FlourishWeb do
    pipe_through [:browser]

    get "/", PageController, :index
    resources "/sessions", SessionController, only: [:create]
  end

  scope "/", FlourishWeb do
    pipe_through [:browser, :authenticated]

    get "/welcome", PageController, :welcome
  end
end
