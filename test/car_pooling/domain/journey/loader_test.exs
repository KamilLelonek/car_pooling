defmodule CarPooling.Domain.Journey.LoaderTest do
  use CarPooling.TestCase, async: true

  alias CarPooling.Domain.Journey.{Loader, Mutator}

  describe "all/0" do
    test "should not load any Journeys" do
      assert [] == Loader.all()
    end

    test "should load a Journey without a Car assigned" do
      Factory.insert(:journey)

      assert [%{car: nil, car_id: nil}] = Loader.all()
    end

    test "should load a Journey with a Car assigned" do
      journey = Factory.insert(:journey)
      car = %{id: car_id} = Factory.insert(:car)

      Mutator.assign_car(journey, car)

      assert [%{car: ^car, car_id: ^car_id}] = Loader.all()
    end
  end

  describe "one/1" do
    test "should not find any Journey" do
      refute Loader.one(1)
    end

    test "should not find a not matching Journey" do
      Factory.insert(:journey)

      refute Loader.one(999)
    end

    test "should find a matching Journey without a Car assigned" do
      %{id: id, people: people} = Factory.insert(:journey)

      assert %{id: id, people: ^people, car: nil, car_id: nil} = Loader.one(id)
    end

    test "should find a matching Journey with a Car assigned" do
      journey = %{id: id} = Factory.insert(:journey)
      car = %{id: car_id} = Factory.insert(:car)

      Mutator.assign_car(journey, car)

      assert %{car: ^car, car_id: ^car_id} = Loader.one(id)
    end
  end
end
