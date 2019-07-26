defmodule CarPoolingWeb.Journey.ControllerTest do
  use CarPooling.TestCase, async: true

  describe "PUT /journey" do
    test "should request Cars", %{conn: conn} do
      journey = read_fixture(:journeys, "valid")

      assert conn
             |> post(Routes.journeys_path(conn, :request), journey)
             |> response(:ok)
    end

    test "should not request Cars for a missing ID", %{conn: conn} do
      journey = read_fixture(:journeys, "missing_id")

      assert conn
             |> post(Routes.journeys_path(conn, :request), journey)
             |> response(:bad_request)
    end

    test "should not request Cars for an invalid JSON", %{conn: conn} do
      assert conn
             |> post(Routes.journeys_path(conn, :request), %{})
             |> response(:bad_request)
    end

    test "should not request Cars for an invalid params", %{conn: conn} do
      journey = read_fixture(:journeys, "invalid_people")

      assert conn
             |> post(Routes.journeys_path(conn, :request), journey: journey)
             |> response(:bad_request)
    end
  end
end
