defmodule CarPooling.Domain.Car.Changeset do
  import Ecto.Changeset

  alias CarPooling.Domain.Car.Schema

  @params_required ~w(id seats)a
  @params_optional ~w()a

  def build(params) do
    %Schema{}
    |> cast(params, @params_required ++ @params_optional)
    |> validate_required(@params_required)
    |> validate_number(:seats, greater_than: 0)
  end
end
