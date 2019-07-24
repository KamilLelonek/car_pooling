defmodule CarPoolingWeb.Router do
  use Phoenix.Router

  alias CarPoolingWeb.Endpoints.Controller, as: EndpointsController

  pipeline :api do
    plug :accepts, ["json"]
  end

  get("/", EndpointsController, :index, as: :endpoints)

  scope "/", CarPoolingWeb do
    pipe_through :api

    put("/cars", Car.Controller, :upload, as: :cars)
  end
end
