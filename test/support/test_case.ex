defmodule CarPooling.TestCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use Phoenix.ConnTest

      alias CarPoolingWeb.Router.Helpers, as: Routes

      @endpoint CarPoolingWeb.Endpoint

      import CarPooling.TestCase
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(CarPooling.Domain.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(CarPooling.Domain.Repo, {:shared, self()})
    end

    :ok
  end

  def errors_on(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {message, opts} ->
      Regex.replace(~r"%{(\w+)}", message, fn _, key ->
        opts
        |> Keyword.get(String.to_existing_atom(key), key)
        |> to_string()
      end)
    end)
  end
end
