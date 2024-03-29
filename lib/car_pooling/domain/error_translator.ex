defmodule CarPooling.Domain.ErrorTranslator do
  @moduledoc """
  A module that translates internal CarPooling.Domain erros to these
  undestandable by CarPoolingWeb and ready to be rendered directly.
  """

  def call(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {message, opts} ->
      Regex.replace(~r"%{(\w+)}", message, fn _, key ->
        opts
        |> Keyword.get(String.to_existing_atom(key), key)
        |> to_string()
      end)
    end)
  end
end
