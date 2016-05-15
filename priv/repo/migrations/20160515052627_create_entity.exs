defmodule Offshore.Repo.Migrations.CreateEntity do
  use Ecto.Migration

  def change do
    create table(:entities) do
      add :name, :string
      add :original_name, :string
      add :former_name, :string
      add :jurisdiction, :string
      add :jurisdiction_description, :string
      add :company_type, :string
      add :address, :string
      add :internal_id, :string
      add :incorporation_date, :date
      add :inactivation_date, :date
      add :struck_off_date, :date
      add :dorm_date, :date
      add :status, :string
      add :service_provider, :string
      add :ibcRUC, :string
      add :country_codes, :string
      add :countries, :string
      add :note, :string
      add :valid_until, :string
      add :node_id, :integer
      add :sourceID, :string

      timestamps
    end
    create unique_index(:entities, [:node_id])

  end
end
