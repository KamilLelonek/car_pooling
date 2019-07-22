defmodule CarPoolingWeb.Router do
  use Phoenix.Router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", CarPoolingWeb do
    pipe_through :api
  end
end
