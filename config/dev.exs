use Mix.Config

config :car_pooling, CarPooling.Domain.Repo,
  database: "car_pooling_dev",
  show_sensitive_data_on_connection_error: true

config :car_pooling, CarPoolingWeb.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  watchers: []

config :phoenix, :plug_init_mode, :runtime
