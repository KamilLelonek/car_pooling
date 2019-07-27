defmodule CarPoolingWeb.Errors.Controller do
  use CarPoolingWeb.Controller

  def method_not_allowed(conn, _params),
    do: send_resp(conn, :method_not_allowed, "")
end
