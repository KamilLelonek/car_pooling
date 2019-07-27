use Mix.Config

config :car_pooling, CarPoolingWeb.Endpoint,
  http: [port: {:system, "PORT"}],
  url: [host: {:system, "HOST"}, port: 80],
  server: true

config :car_pooling, CarPooling.Domain.Repo,
  pool_size: 2,
  load_from_system_env: true
