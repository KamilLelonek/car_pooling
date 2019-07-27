defmodule CarPoolingWeb.Router do
  use Phoenix.Router
  use Plug.ErrorHandler

  alias CarPoolingWeb.Endpoints.Controller, as: EndpointsController

  pipeline :api do
    plug :accepts, ["json"]
  end

  get("/", EndpointsController, :index, as: :endpoints)

  scope "/", CarPoolingWeb do
    pipe_through :api

    put("/cars", Car.Controller, :upload, as: :cars)
    post("/journey", Journey.Controller, :request, as: :journeys)
    post("/locate", Journey.Controller, :locate, as: :journeys)
    post("/dropoff", Journey.Controller, :dropoff, as: :journeys)
  end
end
