defmodule CarPooling.Domain.Car.Schema do
  use Ecto.Schema

  alias CarPooling.Domain.Journey.Schema, as: Journey

  schema "cars" do
    field :seats, :integer

    has_one(:journey, Journey, foreign_key: :id)

    timestamps(updated_at: false)
  end
end
