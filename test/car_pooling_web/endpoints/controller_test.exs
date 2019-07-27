defmodule CarPoolingWeb.Endpoints.ControllerTest do
  use CarPooling.TestCase, async: true

  alias CarPoolingWeb.{Endpoint, Router}
  alias Phoenix.Router.Helpers

  test "GET /whatever should return error page", %{conn: conn} do
    assert_raise Phoenix.Router.NoRouteError, fn ->
      get(conn, "/whatever")
    end
  end

  test "GET / should return current endpoints", %{conn: conn} do
    response =
      conn
      |> get(Routes.endpoints_path(conn, :index))
      |> json_response(:ok)

    assert api() == response
  end

  defp api do
    [
      %{
        "endpoints" => "#{url()}/",
        "method" => "get"
      },
      %{
        "journeys" => "#{url()}/journey",
        "method" => "post"
      },
      %{
        "journeys" => "#{url()}/locate",
        "method" => "post"
      },
      %{
        "journeys" => "#{url()}/dropoff",
        "method" => "post"
      },
      %{
        "cars" => "#{url()}/cars",
        "method" => "put"
      }
    ]
  end

  defp url, do: Helpers.url(Router, Endpoint)
end
