defmodule CarPooling.Factory do
  use ExMachina.Ecto, repo: CarPooling.Domain.Repo

  alias CarPooling.Domain.Car.Schema, as: Car
  alias CarPooling.Domain.Journey.Schema, as: Journey

  def car_factory do
    %Car{
      id: Enum.random(1..100),
      seats: Enum.random(1..100)
    }
  end

  def journey_factory do
    %Journey{
      id: Enum.random(1..100),
      people: Enum.random(1..100)
    }
  end
end
