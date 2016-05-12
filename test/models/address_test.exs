defmodule Offshore.AddressTest do
  use Offshore.ModelCase

  alias Offshore.Address

  @valid_attrs %{address: "some content", countries: "some content", country_codes: "some content", icij_id: "some content", node_id: 42, sourceID: "some content", valid_until: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Address.changeset(%Address{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Address.changeset(%Address{}, @invalid_attrs)
    refute changeset.valid?
  end
end
