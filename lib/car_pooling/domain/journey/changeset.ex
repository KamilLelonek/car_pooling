defmodule CarPooling.Domain.Journey.Changeset do
  @moduledoc """
  Journey schema validation module.
  """

  import Ecto.Changeset

  alias CarPooling.Domain.Journey.Schema

  @params_required ~w(id people)a
  @params_optional ~w()a

  def create(params) do
    %Schema{}
    |> cast(params, @params_required ++ @params_optional)
    |> validate_required(@params_required)
    |> validate_number(:people, greater_than: 0)
    |> unique_constraint(:id, name: :journeys_pkey)
  end
end
