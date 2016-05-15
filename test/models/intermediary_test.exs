defmodule Offshore.IntermediaryTest do
  use Offshore.ModelCase

  alias Offshore.Intermediary

  @valid_attrs %{address: "some content", countries: "some content", country_codes: "some content", internal_id: 42, name: "some content", node_id: 42, sourceID: "some content", status: "some content", valid_until: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Intermediary.changeset(%Intermediary{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Intermediary.changeset(%Intermediary{}, @invalid_attrs)
    refute changeset.valid?
  end
end
