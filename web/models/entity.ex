defmodule Offshore.Entity do
  use Offshore.Web, :model

  schema "entities" do
    field :name, :string
    field :original_name, :string
    field :former_name, :string
    field :jurisdiction, :string
    field :jurisdiction_description, :string
    field :company_type, :string
    field :address, :string
    field :internal_id, :string
    field :incorporation_date, Ecto.Date
    field :inactivation_date, Ecto.Date
    field :struck_off_date, Ecto.Date
    field :dorm_date, Ecto.Date
    field :status, :string
    field :service_provider, :string
    field :ibcRUC, :string
    field :country_codes, :string
    field :countries, :string
    field :note, :string
    field :valid_until, :string
    field :node_id, :integer
    field :sourceID, :string

    timestamps
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :original_name, :former_name, :jurisdiction, :jurisdiction_description, :company_type, :address, :internal_id, :incorporation_date, :inactivation_date, :struck_off_date, :dorm_date, :status, :service_provider, :ibcRUC, :country_codes, :countries, :note, :valid_until, :node_id, :sourceID])
    |> validate_required([:node_id])
    |> unique_constraint(:node_id)
  end
end
