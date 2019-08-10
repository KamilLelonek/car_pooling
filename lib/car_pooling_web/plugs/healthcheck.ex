defmodule CarPoolingWeb.Plug.Healthcheck do
  @moduledoc """
  Application status healthcheck
  available as liviness probe
  under /status endpoint.
  """

  import Plug.Conn

  def init(opts), do: opts

  def call(%Plug.Conn{request_path: "/status"} = conn, _opts) do
    conn
    |> send_resp(200, "OK")
    |> halt()
  end

  def call(conn, _opts), do: conn
end
