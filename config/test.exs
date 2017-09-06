use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :flourish, FlourishWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :flourish, Flourish.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "flourish_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# decrease the password hashing rounds to speed things up a bit
config :bcrypt_elixir, :log_rounds, 4

# Claim-based request authentication
config :flourish, Flourish.Authentication,
  secret_key: %{
    "k" => "_sxhsZM2e5MQktKy_oaiMRZG8uF1YOaM5OIH6cC5xcoRltL9dMCiacv9hLKhqLeFm9uVAGpRy_EW8R6GgUdcyA",
    "kty" => "oct"
  }
