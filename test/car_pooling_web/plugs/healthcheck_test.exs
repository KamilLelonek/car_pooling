defmodule CarPoolingWeb.Plug.HealthcheckTest do
  use CarPooling.TestCase, async: true

  alias CarPoolingWeb.Plug.Healthcheck

  setup do
    {:ok, conn: Phoenix.ConnTest.build_conn(:get, "/status")}
  end

  describe "GET /status" do
    test "should repond with 200 OK when called diectly", %{conn: conn} do
      assert "OK" = conn |> call |> response(200)
    end

    test "should halt the given connection", %{conn: conn} do
      assert %Plug.Conn{halted: true, status: 200, resp_body: "OK"} = call(conn)
    end

    test "should work in a Router", %{conn: conn} do
      defmodule MyRouter do
        use Phoenix.Router

        forward "/status", Healthcheck
      end

      assert %Plug.Conn{
               halted: true,
               status: 200,
               resp_body: "OK",
               request_path: "/status"
             } = MyRouter.call(conn, [])
    end

    test "should work in the Endpoint", %{conn: conn} do
      assert "OK" = conn |> @endpoint.call([]) |> response(200)
    end
  end

  defp call(conn), do: Healthcheck.call(conn, Healthcheck.init([]))
end
