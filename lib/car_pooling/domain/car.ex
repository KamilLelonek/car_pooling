defmodule CarPooling.Domain.Car do
  alias CarPooling.Domain.{Repo, Car.Mutator}
  alias Ecto.Multi

  def upload(cars) do
    Multi.new()
    |> Mutator.multi_delete_all()
    |> Mutator.multi_insert_all(cars)
    |> Repo.transaction()
  end
end
