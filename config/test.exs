use Mix.Config

config :car_pooling, CarPooling.Domain.Repo,
  username: System.get_env("POSTGRES_USER") || "postgres",
  password: System.get_env("POSTGRES_PASSWORD") || "postgres",
  database: System.get_env("POSTGRES_DB") || "car_pooling_test",
  hostname: System.get_env("POSTGRES_HOST") || "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :car_pooling, CarPoolingWeb.Endpoint,
  http: [port: 4002],
  server: false

config :logger, level: :warn
