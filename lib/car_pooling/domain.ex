defmodule CarPooling.Domain do
  alias CarPooling.Domain.{Car, Journey, ErrorTranslator}

  def upload_cars(cars) do
    case Car.upload(cars) do
      {:ok, _result} ->
        :ok

      {:error, {:car, id, _transaction_id}, changeset, _} ->
        {:error, %{id: id, fields: ErrorTranslator.call(changeset)}}
    end
  end

  def request_journey(params) do
    case Journey.request(params) do
      {:ok, _result} ->
        :ok

      {:error, changeset} ->
        {:error, %{fields: ErrorTranslator.call(changeset)}}
    end
  end

  def find_journey(params) do
    with %{"ID" => id} <- params,
         journey when not is_nil(journey) <- Journey.one(id) do
      {:ok, journey}
    else
      nil -> {:error, :not_found}
      _ -> {:error, :invalid_params}
    end
  end

  def dropoff_journey(params) do
    with %{"ID" => id} <- params,
         {1, nil} <- Journey.delete(id) do
      :ok
    else
      {0, nil} -> {:error, :not_found}
      _ -> {:error, :invalid_params}
    end
  end
end
