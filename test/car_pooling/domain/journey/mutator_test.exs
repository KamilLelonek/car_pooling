defmodule CarPooling.Domain.Journey.MutatorTest do
  use CarPooling.TestCase, async: true

  alias CarPooling.Domain.Journey.{Mutator, Schema}
  alias CarPooling.Domain.ErrorTranslator

  describe "create/1" do
    test "should create a new Journey" do
      journey = read_fixture(:journeys, "valid")

      assert {
               :ok,
               %Schema{
                 car_id: nil,
                 id: 1,
                 people: 4
               }
             } = Mutator.create(journey)
    end

    test "should not create a new Journey with invalid People" do
      journey = read_fixture(:journeys, "invalid_people")

      assert {:error, changeset} = Mutator.create(journey)
      assert %{people: ["must be greater than 0"]} == ErrorTranslator.call(changeset)
    end

    test "should not create a new Journey with missing People" do
      journey = read_fixture(:journeys, "missing_people")

      assert {:error, changeset} = Mutator.create(journey)
      assert %{people: ["can't be blank"]} == ErrorTranslator.call(changeset)
    end

    test "should not create a new Journey with missing ID" do
      journey = read_fixture(:journeys, "missing_id")

      assert {:error, changeset} = Mutator.create(journey)
      assert %{id: ["can't be blank"]} == ErrorTranslator.call(changeset)
    end
  end

  describe "assign_car/2" do
    test "should assign a Car to a Journey" do
      car = Factory.insert(:car)
      journey = Factory.insert(:journey)

      assert {:ok, %{car_id: car_id, car: %{id: car_id}}} = Mutator.assign_car(journey, car)
    end
  end

  describe "delete/1" do
    test "should delete a Journey without a Car" do
      %{id: id} = Factory.insert(:journey)

      assert {1, nil} = Mutator.delete(id)
    end

    test "should delete a Journey with a Car" do
      car = Factory.insert(:car)
      journey = %{id: id} = Factory.insert(:journey)

      Mutator.assign_car(journey, car)

      assert {1, nil} = Mutator.delete(id)
    end

    test "should not delete a Journey" do
      assert {0, nil} = Mutator.delete(1)
    end
  end
end
