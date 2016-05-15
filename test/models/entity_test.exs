defmodule Offshore.EntityTest do
  use Offshore.ModelCase

  alias Offshore.Entity

  @valid_attrs %{address: "some content", company_type: "some content", countries: "some content", country_codes: "some content", dorm_date: %{day: 17, month: 4, year: 2010}, former_name: "some content", ibcRUC: "some content", inactivation_date: %{day: 17, month: 4, year: 2010}, incorporation_date: %{day: 17, month: 4, year: 2010}, internal_id: "some content", jurisdiction: "some content", jurisdiction_description: "some content", name: "some content", node_id: 42, note: "some content", original_name: "some content", service_provider: "some content", sourceID: "some content", status: "some content", struck_off_date: %{day: 17, month: 4, year: 2010}, valid_until: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Entity.changeset(%Entity{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Entity.changeset(%Entity{}, @invalid_attrs)
    refute changeset.valid?
  end
end
