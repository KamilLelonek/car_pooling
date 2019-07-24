defmodule CarPoolingWeb.Car.Controller do
  use CarPoolingWeb.Controller

  alias CarPooling.Domain

  def upload(conn, params) do
    with %{"_json" => cars} when is_list(cars) <- params,
         :ok <- Domain.upload_cars(cars) do
      send_text(conn, :ok)
    else
      _ -> send_text(conn, :bad_request)
    end
  end

  defp send_text(conn, status) do
    conn
    |> put_status(status)
    |> text("")
  end
end
