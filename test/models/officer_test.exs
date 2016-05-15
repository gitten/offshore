defmodule Offshore.OfficerTest do
  use Offshore.ModelCase

  alias Offshore.Officer

  @valid_attrs %{countries: "some content", country_codes: "some content", icij_id: "some content", name: "some content", node_id: 42, sourceID: "some content", valid_until: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Officer.changeset(%Officer{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Officer.changeset(%Officer{}, @invalid_attrs)
    refute changeset.valid?
  end
end
