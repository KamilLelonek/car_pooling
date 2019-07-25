defmodule CarPooling.Domain.Repo.Migrations.CreateJourneys do
  use Ecto.Migration

  def change do
    create table("journeys") do
      add :people, :integer, null: false
      add :car_id, references(:cars), null: true

      timestamps()
    end

    create index("journeys", :people)
  end
end
