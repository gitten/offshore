defmodule Offshore.Router do
  use Offshore.Web, :router

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

  scope "/", Offshore do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/addresses", AddressController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Offshore do
  #   pipe_through :api
  # end
end
