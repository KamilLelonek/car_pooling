use Mix.Config

config :car_pooling, CarPoolingWeb.Endpoint,
  http: [port: {:system, "PORT"}],
  url: [host: {:system, "HOST"}, port: 80],
  cache_static_manifest: "priv/static/cache_manifest.json",
  server: true

config :car_pooling, CarPooling.Domain.Repo, load_from_system_env: true
