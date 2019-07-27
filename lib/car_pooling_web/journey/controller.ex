defmodule CarPoolingWeb.Journey.Controller do
  use CarPoolingWeb.Controller

  alias CarPooling.Domain

  def request(conn, params) do
    case Domain.request_journey(params) do
      :ok -> send_text(conn, :ok)
      _ -> send_text(conn, :bad_request)
    end
  end

  def locate(conn, params) do
    case Domain.find_journey(params) do
      {:ok, %{car: nil}} -> send_text(conn, :no_content)
      {:ok, %{car: car}} -> json(conn, car)
      {:error, :not_found} -> send_text(conn, :not_found)
      {:error, :invalid_params} -> send_text(conn, :bad_request)
    end
  end

  def dropoff(conn, params) do
    case Domain.dropoff_journey(params) do
      :ok -> send_text(conn, :ok)
      {:error, :not_found} -> send_text(conn, :not_found)
      {:error, :invalid_params} -> send_text(conn, :bad_request)
    end
  end

  defp send_text(conn, status) do
    conn
    |> put_status(status)
    |> text("")
  end
end
