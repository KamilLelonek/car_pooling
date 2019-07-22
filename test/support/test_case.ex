defmodule CarPooling.TestCase do
  use ExUnit.CaseTemplate

  alias CarPooling.Domain.Repo
  alias Ecto.Adapters.SQL.Sandbox

  using do
    quote do
      use Phoenix.ConnTest

      alias CarPoolingWeb.Router.Helpers, as: Routes

      @endpoint CarPoolingWeb.Endpoint

      import CarPooling.TestCase
    end
  end

  setup tags do
    :ok = Sandbox.checkout(Repo)

    unless tags[:async] do
      Sandbox.mode(Repo, {:shared, self()})
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
