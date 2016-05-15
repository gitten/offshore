defmodule Offshore.Repo.Migrations.CreateOfficer do
  use Ecto.Migration

  def change do
    create table(:officers) do
      add :name, :string
      add :icij_id, :string
      add :valid_until, :string
      add :country_codes, :string
      add :countries, :string
      add :node_id, :integer
      add :sourceID, :string

      timestamps
    end
    create unique_index(:officers, [:node_id])

  end
end
