defmodule CarPooling.Domain.Journey.Schema do
  @moduledoc """
  Journey entity representation
  and schema definition module.
  """

  use Ecto.Schema

  alias CarPooling.Domain.Car.Schema, as: Car

  schema "journeys" do
    field :people, :integer

    belongs_to(:car, Car)

    timestamps()
  end
end
