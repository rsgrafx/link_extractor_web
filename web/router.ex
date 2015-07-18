defmodule LinkExtractorWeb.Router do
  use LinkExtractorWeb.Web, :router

  pipeline :browser do
    plug :accepts, ["html", "json"]
    plug :fetch_session
    plug :fetch_flash
    # plug :protect_from_forgery
  end

  pipeline :api do
    plug CORSPlug, [origin: "*"]
    plug :accepts, ["json"]
    post "/messages", MessagesController, :create
  end

  scope "/", LinkExtractorWeb do
    pipe_through :browser # Use the default browser stack
    get "/", PageController, :index
    post "/messages", MessagesController, :create
    get "/messages", MessagesController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", LinkExtractorWeb do
    pipe_through :api
    resources "/posts", PostController
  end
end
