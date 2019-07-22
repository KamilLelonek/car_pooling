defmodule CarPoolingWeb.Router do
  use Phoenix.Router

  alias CarPoolingWeb.Endpoints.Controller, as: EndpointsController

  pipeline :api do
    plug :accepts, ["json"]
  end

  get("/", EndpointsController, :index, as: :endpoints)

  scope "/api", CarPoolingWeb do
    pipe_through :api
  end
end
