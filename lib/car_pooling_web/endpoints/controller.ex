defmodule CarPoolingWeb.Endpoints.Controller do
  use CarPoolingWeb.Controller

  alias CarPoolingWeb.Endpoints.View

  def index(conn, _params) do
    conn
    |> put_status(200)
    |> put_view(View)
    |> render("endpoints.json")
  end
end
