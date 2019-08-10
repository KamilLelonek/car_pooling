defmodule CarPooling.Domain.Car.Loader do
  @moduledoc """
  The Queries part of Car CQRS model.
  """

  alias CarPooling.Domain.Repo
  alias CarPooling.Domain.Car.Schema, as: Car
  alias CarPooling.Domain.Journey.Schema, as: Journey

  import Ecto.Query, only: [from: 2]

  def by_seats(seats) do
    Repo.one(
      from car in Car,
        left_join: journey in Journey,
        on: car.id == journey.car_id,
        where: is_nil(journey.car_id),
        where: car.seats >= type(^seats, :integer),
        order_by: car.seats,
        limit: 1
    )
  end
end
