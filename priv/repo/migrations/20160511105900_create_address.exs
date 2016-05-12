defmodule Offshore.Repo.Migrations.CreateAddress do
  use Ecto.Migration

  def change do
    create table(:addresses) do
      add :address, :string
      add :icij_id, :string
      add :valid_until, :string
      add :country_codes, :string
      add :countries, :string
      add :node_id, :integer
      add :sourceID, :string

      timestamps
    end
    create unique_index(:addresses, [:node_id])

  end
end
