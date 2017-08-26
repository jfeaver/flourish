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
