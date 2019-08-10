defmodule CarPooling.DomainTest do
  use CarPooling.TestCase, async: true

  alias CarPooling.Domain

  describe "upload_cars/1" do
    test "should upload Cars" do
      cars = read_fixture(:cars, "valid")

      assert :ok = Domain.upload_cars(cars)
    end

    test "should upload Cars even with Journey assigned" do
      cars = read_fixture(:cars, "valid")
      journey = read_fixture(:journeys, "valid")

      Domain.upload_cars(cars)
      Domain.request_journey(journey)

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

  describe "find_journey/1" do
    test "should find a Journey withouth a Car assigned" do
      :journeys
      |> read_fixture("valid")
      |> Domain.request_journey()

      assert {:ok, %{id: 1, car: nil, car_id: nil}} = Domain.find_journey(%{"ID" => 1})
    end

    test "should find a Journey with a Car assigned" do
      cars = read_fixture(:cars, "valid")
      journey = read_fixture(:journeys, "valid")

      Domain.upload_cars(cars)
      Domain.request_journey(journey)

      assert {:ok, %{id: 1, people: 4, car: %{seats: 4}, car_id: 1}} =
               Domain.find_journey(%{"ID" => 1})
    end

    test "should not find any Journey" do
      assert {:error, :not_found} == Domain.find_journey(%{"ID" => 1})
    end

    test "should not find any Journey and return an error" do
      assert {:error, :invalid_params} == Domain.find_journey(%{"id" => 1})
      assert_raise Ecto.Query.CastError, fn -> Domain.find_journey(%{"ID" => "a"}) end
    end
  end

  describe "dropoff_journey/1" do
    test "should not dropoff any Journey" do
      assert {:error, :not_found} = Domain.dropoff_journey(%{"ID" => 1})
    end

    test "should not dropoff any Journey and return an error" do
      assert {:error, :invalid_params} == Domain.dropoff_journey(%{"id" => 1})
      assert_raise Ecto.Query.CastError, fn -> Domain.dropoff_journey(%{"ID" => "a"}) end
    end

    test "should dropoff a Journey without a Car" do
      :journeys
      |> read_fixture("valid")
      |> Domain.request_journey()

      assert :ok = Domain.dropoff_journey(%{"ID" => 1})
    end

    test "should dropoff a Journey with a Car" do
      cars = read_fixture(:cars, "valid")
      journey = read_fixture(:journeys, "valid")

      Domain.upload_cars(cars)
      Domain.request_journey(journey)

      assert :ok = Domain.dropoff_journey(%{"ID" => 1})
    end
  end
end
