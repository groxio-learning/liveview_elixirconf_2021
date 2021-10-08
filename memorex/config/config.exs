# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :memorex,
  ecto_repos: [Memorex.Repo]

# Configures the endpoint
config :memorex, MemorexWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "sLnKCEEuVlsgG4hfoyS4M1IfO3ro4XwX9AR+wjb5AAJC653tG4kbay6pst2Ug/I9",
  render_errors: [view: MemorexWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Memorex.PubSub,
  live_view: [signing_salt: "5bKxaJ00"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
