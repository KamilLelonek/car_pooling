defmodule CarPooling.DomainTest do
  use CarPooling.TestCase, async: true

  alias CarPooling.Domain

  describe "upload_cars/1" do
    test "should upload Cars" do
      cars = read_fixture(:cars, "valid")

      assert :ok = Domain.upload_cars(cars)
    end

    test "should not upload Cars and return an error" do
      cars = read_fixture(:cars, "duplicated_id")

      assert {:error, %{id: 5, fields: %{id: ["has already been taken"]}}} =
               Domain.upload_cars(cars)
    end
  end

  describe "request_journey/1" do
    test "should request Journey" do
      journey = read_fixture(:journeys, "valid")

      assert :ok = Domain.request_journey(journey)
    end

    test "should not request Journey and return an error" do
      journey = read_fixture(:journeys, "missing_people")

      assert {:error, %{fields: %{people: ["can't be blank"]}}} = Domain.request_journey(journey)
    end
  end
end
