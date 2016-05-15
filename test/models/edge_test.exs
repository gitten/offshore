defmodule Offshore.EdgeTest do
  use Offshore.ModelCase

  alias Offshore.Edge

  @valid_attrs %{node_1: 42, node_2: 42, rel_type: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Edge.changeset(%Edge{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Edge.changeset(%Edge{}, @invalid_attrs)
    refute changeset.valid?
  end
end
