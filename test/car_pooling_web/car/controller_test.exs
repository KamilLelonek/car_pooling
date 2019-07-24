defmodule CarPoolingWeb.Car.ControllerTest do
  use CarPooling.TestCase, async: true

  describe "PUT /cars" do
    test "should upload Cars", %{conn: conn} do
      cars = read_fixture(:cars, "valid")

      assert conn
             |> put(Routes.cars_path(conn, :upload), _json: cars)
             |> response(:ok)
    end

    test "should not upload Cars for an invalid ID", %{conn: conn} do
      cars = read_fixture(:cars, "invalid_id")

      assert conn
             |> put(Routes.cars_path(conn, :upload), _json: cars)
             |> response(:bad_request)
    end

    test "should not upload Cars for an invalid JSON", %{conn: conn} do
      assert conn
             |> put(Routes.cars_path(conn, :upload), _json: %{})
             |> response(:bad_request)
    end

    test "should not upload Cars for an invalid params", %{conn: conn} do
      cars = read_fixture(:cars, "invalid_id")

      assert conn
             |> put(Routes.cars_path(conn, :upload), cars: cars)
             |> response(:bad_request)
    end
  end
end
