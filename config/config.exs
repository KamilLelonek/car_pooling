use Mix.Config

config :car_pooling,
  ecto_repos: [CarPooling.Domain.Repo],
  generators: [binary_id: true]

config :car_pooling, CarPoolingWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "jQuADUDDxCN02g+s9CD2Cxp2WDMRgj9HBMW8a9oUb2+laDKhaU2k+M0KvVk7uQ+y",
  render_errors: [view: CarPoolingWeb.ErrorView, accepts: ~w(json)],
  check_origin: false,
  pubsub: [name: CarPooling.PubSub, adapter: Phoenix.PubSub.PG2]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix,
  stacktrace_depth: 40,
  json_library: Jason

config :car_pooling, CarPooling.Domain.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

import_config "#{Mix.env()}.exs"
