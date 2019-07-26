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
end
