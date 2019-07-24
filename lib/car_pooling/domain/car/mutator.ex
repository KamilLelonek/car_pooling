defmodule CarPooling.Domain.Car.Mutator do
  alias CarPooling.Domain.Car.{Changeset, Schema}
  alias Ecto.Multi

  def multi_delete_all(multi),
    do: Multi.delete_all(multi, :delete_all, Schema)

  def multi_insert_all(multi, cars),
    do: Enum.reduce(cars, multi, &multi_insert_one/2)

  defp multi_insert_one(car, multi) do
    Multi.insert(
      multi,
      {:car, car["id"], Ecto.UUID.generate()},
      Changeset.build(car)
    )
  end
end
