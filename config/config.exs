# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :fullstack_challenge,
  ecto_repos: [FullstackChallenge.Repo]

# Configures the endpoint
config :fullstack_challenge, FullstackChallengeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Ow2Hy4X/ek+xDuiesfRHHcLES469w0GPDsUo03be9C6iUO4ayRa+B71Jt0zRgA98",
  render_errors: [view: FullstackChallengeWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: FullstackChallenge.PubSub,
  live_view: [signing_salt: "izkEPbJD"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
