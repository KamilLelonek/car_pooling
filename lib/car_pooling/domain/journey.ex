defmodule CarPooling.Domain.Journey do
  @moduledoc """
  An entry point for CarPooling.Domain to manage Journeys.
  """

  alias CarPooling.Domain.Journey.Mutator
  alias CarPooling.Domain.Journey.Loader, as: JourneyLoader
  alias CarPooling.Domain.Car.Loader, as: CarLoader

  defdelegate one(id), to: JourneyLoader
  defdelegate delete(id), to: Mutator

  def request(params) do
    case Mutator.create(params) do
      {:ok, %{people: people} = journey} ->
        people
        |> CarLoader.by_seats()
        |> maybe_assign_car(journey)

      error ->
        error
    end
  end

  defp maybe_assign_car(nil, journey), do: {:ok, journey}
  defp maybe_assign_car(car, journey), do: Mutator.assign_car(journey, car)
end
