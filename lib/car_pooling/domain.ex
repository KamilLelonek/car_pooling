defmodule CarPooling.Domain do
  alias CarPooling.Domain.{Car, ErrorTranslator}

  def upload_cars(cars) do
    case Car.upload(cars) do
      {:ok, _result} ->
        :ok

      {:error, {:car, id, _transaction_id}, changeset, _} ->
        {:error, %{id: id, fields: ErrorTranslator.call(changeset)}}
    end
  end
end
