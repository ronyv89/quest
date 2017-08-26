defmodule QuestWeb.Router do
  use QuestWeb, :router
  use Coherence.Router
  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Coherence.Authentication.Session  # Add this
  end

  pipeline :protected do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Coherence.Authentication.Session, protected: true  # Add this
  end

  # Add this block
  scope "/" do
    pipe_through :browser
    coherence_routes()
  end

  # Add this block
  scope "/" do
    pipe_through :protected
    coherence_routes :protected
  end

  scope "/", QuestWeb do
    pipe_through :browser
    get "/", PageController, :index
    # Add public routes below
  end

  scope "/admin", QuestWeb.Admin, as: :admin do
    pipe_through :protected
    resources "/topics", TopicController
  end

  scope "/", QuestWeb do
    pipe_through :protected
    resources "/profile", ProfileController, singleton: true
    resources "/topics", TopicController, only: [:index, :show]
    # Add protected routes below
  end
end
