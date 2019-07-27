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

  describe "POST /locate" do
    test "should find a Car and render 200", %{conn: conn} do
      journey = read_fixture(:journeys, "valid")
      cars = read_fixture(:cars, "valid")

      put(conn, Routes.cars_path(conn, :upload), _json: cars)
      post(conn, Routes.journeys_path(conn, :request), journey)

      assert %{"id" => 1, "seats" => 4} =
               conn
               |> put_req_header("content-type", "application/x-www-form-urlencoded")
               |> post(Routes.journeys_path(conn, :locate), %{"ID" => 1})
               |> json_response(:ok)
    end

    test "should not find a Car and render 204", %{conn: conn} do
      journey = read_fixture(:journeys, "valid")

      post(conn, Routes.journeys_path(conn, :request), journey)

      assert conn
             |> put_req_header("content-type", "application/x-www-form-urlencoded")
             |> post(Routes.journeys_path(conn, :locate), %{"ID" => 1})
             |> response(:no_content)
    end

    test "should not find a Car and render 404", %{conn: conn} do
      assert conn
             |> put_req_header("content-type", "application/x-www-form-urlencoded")
             |> post(Routes.journeys_path(conn, :locate), %{"ID" => 1})
             |> response(:not_found)
    end

    test "should not find a Car and render 400", %{conn: conn} do
      assert conn
             |> put_req_header("content-type", "application/x-www-form-urlencoded")
             |> post(Routes.journeys_path(conn, :locate), %{"id" => 1})
             |> response(:bad_request)

      assert_error_sent :bad_request, fn ->
        conn
        |> put_req_header("content-type", "application/x-www-form-urlencoded")
        |> post(Routes.journeys_path(conn, :locate), %{"ID" => "a"})
      end
    end
  end
end
