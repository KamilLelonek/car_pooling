defmodule CarPooling.Domain.Journey.Loader do
  @moduledoc """
  The Queries part of Journey CQRS model.
  """

  alias CarPooling.Domain.Repo
  alias CarPooling.Domain.Journey.Schema, as: Journey

  import Ecto.Query, only: [from: 2]

  def all,
    do: Repo.all(journeys())

  def one(id) do
    Repo.one(
      from journeys(),
        where: [id: ^id]
    )
  end

  defp journeys do
    from journey in Journey,
      left_join: car in assoc(journey, :car),
      preload: :car
  end
end
