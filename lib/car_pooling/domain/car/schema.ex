defmodule CarPooling.Domain.Car.Schema do
  use Ecto.Schema

  schema "cars" do
    field :seats, :integer

    timestamps(updated_at: false)
  end
end
