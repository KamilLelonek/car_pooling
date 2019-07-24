use Mix.Config

config :car_pooling, CarPooling.Domain.Repo,
  database: "car_pooling_test",
  pool: Ecto.Adapters.SQL.Sandbox

config :car_pooling, CarPoolingWeb.Endpoint,
  http: [port: 4002],
  server: false

config :logger, level: :warn
