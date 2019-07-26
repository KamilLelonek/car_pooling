defmodule CarPooling.Domain.Journey do
  alias CarPooling.Domain.Journey.Mutator
  alias CarPooling.Domain.Car.Loader

  def request(params) do
    case Mutator.create(params) do
      {:ok, %{people: people} = journey} ->
        people
        |> Loader.by_seats()
        |> maybe_assign_car(journey)

      error ->
        error
    end
  end

  defp maybe_assign_car([car | _], journey), do: Mutator.assign_car(journey, car)
  defp maybe_assign_car([], journey), do: {:ok, journey}
end
