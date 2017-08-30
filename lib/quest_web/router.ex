defmodule QuestWeb.Router do
  use QuestWeb, :router
  use Coherence.Router
  use ExAdmin.Router
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

  pipeline :admin_routes do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Coherence.Authentication.Session, protected: true  # Add this
    plug QuestWeb.Plug.Admin
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

  scope "/admin", ExAdmin do
    pipe_through :admin_routes
    admin_routes()
  end

  # scope "/admin", QuestWeb.Admin, as: :admin do
  #   pipe_through :admin_routes
  #   resources "/topics", TopicController
  # end

  scope "/", QuestWeb do
    pipe_through :protected
    resources "/profile", ProfileController, singleton: true
    get "/account/setup", PageController, :setup_account, as: :setup_account
    resources "/topics", TopicController, only: [:index, :show]
    # Add protected routes below
  end

  if Mix.env == :dev do
    scope "/dev" do
      pipe_through [:browser]
      forward "/mailbox", Plug.Swoosh.MailboxPreview, [base_path: "/dev/mailbox"]
    end
  end
end
