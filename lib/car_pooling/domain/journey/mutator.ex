defmodule CarPooling.Domain.Journey.Mutator do
  alias CarPooling.Domain.{Journey.Changeset, Repo}
  alias CarPooling.Domain.Journey.Schema, as: Journey

  import Ecto.Query, only: [from: 2]

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

  def delete(id) do
    Repo.delete_all(
      from Journey,
        where: [id: ^id]
    )
  end
end
