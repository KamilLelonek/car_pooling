defmodule CarPooling.Domain.CarTest do
  use CarPooling.TestCase, async: true

  alias CarPooling.Domain.{Car, ErrorTranslator}

  describe "upload/1" do
    test "should insert all Cars" do
      cars = read_fixture(:cars, "valid")

      assert {
               :ok,
               %{
                 :delete_all => {0, nil},
                 {:car, 1} => %{id: 1, seats: 4},
                 {:car, 2} => %{id: 2, seats: 7}
               }
             } = Car.upload(cars)
    end

    test "should replace old Cars" do
      cars = read_fixture(:cars, "valid")

      Car.upload(cars)

      assert {
               :ok,
               %{
                 :delete_all => {2, nil},
                 {:car, 1} => %{id: 1, seats: 4},
                 {:car, 2} => %{id: 2, seats: 7}
               }
             } = Car.upload(cars)
    end

    test "should not instert Car with invalid ID" do
      cars = read_fixture(:cars, "invalid_id")

      assert {:error, {:car, "a"}, changeset, %{}} = Car.upload(cars)

      assert %{id: ["is invalid"]} == ErrorTranslator.call(changeset)
    end

    test "should not instert Car with invalid seats" do
      cars = read_fixture(:cars, "invalid_seats")

      assert {:error, {:car, 1}, changeset, %{}} = Car.upload(cars)

      assert %{seats: ["must be greater than 0"]} == ErrorTranslator.call(changeset)
    end

    test "should not instert Car with missing ID" do
      cars = read_fixture(:cars, "missing_id")

      assert {:error, {:car, nil}, changeset, %{}} = Car.upload(cars)

      assert %{id: ["can't be blank"]} == ErrorTranslator.call(changeset)
    end

    test "should not instert Car with missing seats" do
      cars = read_fixture(:cars, "missing_seats")

      assert {:error, {:car, 2}, changeset, %{}} = Car.upload(cars)

      assert %{seats: ["can't be blank"]} == ErrorTranslator.call(changeset)
    end
  end
end
