defmodule CarPooling.Domain.Repo.Migrations.CreateCars do
  use Ecto.Migration

  def change do
    create table("cars") do
      add :seats, :integer, null: false

      timestamps(updated_at: false)
    end

    create index("cars", :seats)
  end
end
