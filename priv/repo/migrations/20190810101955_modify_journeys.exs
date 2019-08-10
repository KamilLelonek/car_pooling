defmodule CarPooling.Domain.Repo.Migrations.ModifyJourneys do
  use Ecto.Migration

  def change do
    alter table("journeys") do
      remove :car_id
      add :car_id, references(:cars, on_delete: :delete_all), null: true
    end
  end
end
