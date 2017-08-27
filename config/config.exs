# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :quest,
  ecto_repos: [Quest.Repo]
config :arc,
  storage: Arc.Storage.Local
# config :ex_admin,
#   repo: Quest.Repo,
#   module: QuestWeb,    # MyProject.Web for phoenix >= 1.3.0-rc 
#   modules: [
#     Quest.ExAdmin.Dashboard,
#   ]
# Configures the endpoint
config :quest, QuestWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "mOn9ewX+NXWCREA9V0glUatvMneB7nbJcl8RxaYxVZ7NaTaDOsnVWCCg5OdjRvXO",
  render_errors: [view: QuestWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Quest.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# %% Coherence Configuration %%   Don't remove this line
config :coherence,
  user_schema: Quest.Coherence.User,
  repo: Quest.Repo,
  module: Quest,
  web_module: QuestWeb,
  router: QuestWeb.Router,
  messages_backend: QuestWeb.Coherence.Messages,
  logged_out_url: "/",
  email_from_name: "Rony Varghese",
  email_from_email: "admin@questqna.herokuapp.com",
  opts: [:invitable, :authenticatable, :recoverable, :lockable, :trackable, :unlockable_with_token, :confirmable, :registerable]

if Mix.env == :dev do
  config :coherence, QuestWeb.Coherence.Mailer,
    adapter: Swoosh.Adapters.Local
else
  config :coherence, QuestWeb.Coherence.Mailer,
    adapter: Swoosh.Adapters.Sendgrid,
    api_key: System.get_env("SENDGRID_API_KEY")
end
