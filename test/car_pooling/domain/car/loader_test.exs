defmodule CarPooling.Domain.Car.LoaderTest do
  use CarPooling.TestCase, async: true

  alias CarPooling.Domain.{Car.Loader, Journey.Mutator}

  describe "by_seats/1" do
    test "should find a Car with available seats" do
      car = Factory.insert(:car, seats: 10)

      assert [^car] = Loader.by_seats(8)
    end

    test "should not find a Car with not enough seats" do
      Factory.insert(:car, seats: 1)

      assert [] == Loader.by_seats(8)
    end

    test "should not find a Car with enough seats but a Journey assigned" do
      car = Factory.insert(:car, seats: 10)
      journey = Factory.insert(:journey)

      Mutator.assign_car(journey, car)

      assert [] == Loader.by_seats(8)
    end

    test "should not find mutliple Cars with enough seats" do
      car1 = Factory.insert(:car, seats: 11)
      car2 = Factory.insert(:car, seats: 12)
      car3 = Factory.insert(:car, seats: 13)
      journey = Factory.insert(:journey)

      Mutator.assign_car(journey, car3)

      assert [^car1, ^car2] = Loader.by_seats(8)
    end
  end
end
