defmodule CarPooling.Domain.Journey.Mutator do
  alias CarPooling.Domain.{Journey.Changeset, Repo}

  def create(params) do
    params
    |> Changeset.create()
    |> Repo.insert()
  end

  def assign_car(journey, car) do
    journey
    |> Repo.preload(:car)
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:car, car)
    |> Repo.update()
  end
end
