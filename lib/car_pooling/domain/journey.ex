defmodule CarPooling.Domain.Journey do
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

  defp maybe_assign_car([car | _], journey), do: Mutator.assign_car(journey, car)
  defp maybe_assign_car([], journey), do: {:ok, journey}
end
