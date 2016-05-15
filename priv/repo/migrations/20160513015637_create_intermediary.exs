defmodule Offshore.Repo.Migrations.CreateIntermediary do
  use Ecto.Migration

  def change do
    create table(:intermediaries) do
      add :name, :string
      add :internal_id, :string
      add :address, :string
      add :valid_until, :string
      add :country_codes, :string
      add :countries, :string
      add :status, :string
      add :node_id, :integer
      add :sourceID, :string

      timestamps
    end
    create unique_index(:intermediaries, [:internal_id])
    create unique_index(:intermediaries, [:node_id])

  end
end
