defmodule Retro.Router do
  use Retro.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Retro do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/v1", Retro do
     pipe_through :api

     resources "/cards", CardController
  end
end
