defmodule CarPoolingWeb.Journey.Controller do
  use CarPoolingWeb.Controller

  alias CarPooling.Domain

  def request(conn, params) do
    case Domain.request_journey(params) do
      :ok -> send_text(conn, :ok)
      _ -> send_text(conn, :bad_request)
    end
  end

  defp send_text(conn, status) do
    conn
    |> put_status(status)
    |> text("")
  end
end
