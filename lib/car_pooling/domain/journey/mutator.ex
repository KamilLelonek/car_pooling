defmodule CarPooling.Domain.Journey.Mutator do
  alias CarPooling.Domain.{Journey.Changeset, Repo}

  def create(params) do
    params
    |> Changeset.create()
    |> Repo.insert()
  end
end
