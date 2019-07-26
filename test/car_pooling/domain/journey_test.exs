defmodule CarPooling.Domain.JourneyTest do
  use CarPooling.TestCase, async: true

  alias CarPooling.Domain.{Journey, ErrorTranslator}

  describe "request/1" do
    test "should request a Car for a Journey" do
      journey = read_fixture(:journeys, "valid")
      %{id: car_id} = Factory.insert(:car, seats: 100)

      assert {:ok, %{car_id: ^car_id}} = Journey.request(journey)
    end

    test "should not request a Car for a Journey twice" do
      journey = read_fixture(:journeys, "valid")

      Factory.insert(:car, seats: 100)
      Journey.request(journey)

      assert {:error, changeset} = Journey.request(journey)
      assert %{id: ["has already been taken"]} == ErrorTranslator.call(changeset)
    end

    test "should not request a Car for a Journey when all Cars are taken" do
      Factory.insert(:car, seats: 100)

      :journeys
      |> read_fixture("valid")
      |> Journey.request()

      journey = %{read_fixture(:journeys, "valid") | "id" => 100}

      assert {:ok, %{car_id: nil}} = Journey.request(journey)
    end

    test "should not request a Car for a Journey when no Car is available" do
      journey = read_fixture(:journeys, "valid")

      assert {:ok, %{car_id: nil}} = Journey.request(journey)
    end

    test "should not request a Car for a Journey when there is not enough seats" do
      journey = read_fixture(:journeys, "valid")

      Factory.insert(:car, seats: 1)

      assert {:ok, %{car_id: nil}} = Journey.request(journey)
    end
  end
end
