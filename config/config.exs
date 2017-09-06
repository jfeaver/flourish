# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :flourish,
  ecto_repos: [Flourish.Repo]

# Configures the endpoint
config :flourish, FlourishWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "uslYeZ3xusgrodqhU4+UjjDe4Ht6wSAIH9QOJugGCs8srlwLWv1xJurZT8nvSCjs",
  render_errors: [view: FlourishWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Flourish.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Claim-based request authentication
config :flourish, Flourish.Authentication,
  issuer: "Flourish",
  ttl: { 5, :days },
  allowed_drift: 2000

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
