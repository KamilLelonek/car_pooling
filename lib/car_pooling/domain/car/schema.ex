defmodule CarPooling.Domain.Car.Schema do
  @moduledoc """
  Car entity representation
  and schema definition module.
  """

  use Ecto.Schema

  alias CarPooling.Domain.Journey.Schema, as: Journey

  @derive {Jason.Encoder, only: [:id, :seats]}

  schema "cars" do
    field :seats, :integer

    has_one(:journey, Journey, foreign_key: :id)

    timestamps(updated_at: false)
  end
end
