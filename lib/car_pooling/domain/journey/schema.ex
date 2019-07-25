defmodule CarPooling.Domain.Journey.Schema do
  use Ecto.Schema

  alias CarPooling.Domain.Car.Schema, as: Car

  schema "journeys" do
    field :people, :integer

    belongs_to(:car, Car)

    timestamps()
  end
end
