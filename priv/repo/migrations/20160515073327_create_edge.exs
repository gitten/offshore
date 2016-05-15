defmodule Offshore.Repo.Migrations.CreateEdge do
  use Ecto.Migration

  def change do
    create table(:edges) do
      add :node_1, :integer
      add :rel_type, :string
      add :node_2, :integer

      timestamps
    end

  end
end
