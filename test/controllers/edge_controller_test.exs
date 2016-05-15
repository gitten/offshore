defmodule Offshore.EdgeControllerTest do
  use Offshore.ConnCase

  alias Offshore.Edge
  @valid_attrs %{node_1: 42, node_2: 42, rel_type: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, edge_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing edges"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, edge_path(conn, :new)
    assert html_response(conn, 200) =~ "New edge"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, edge_path(conn, :create), edge: @valid_attrs
    assert redirected_to(conn) == edge_path(conn, :index)
    assert Repo.get_by(Edge, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, edge_path(conn, :create), edge: @invalid_attrs
    assert html_response(conn, 200) =~ "New edge"
  end

  test "shows chosen resource", %{conn: conn} do
    edge = Repo.insert! %Edge{}
    conn = get conn, edge_path(conn, :show, edge)
    assert html_response(conn, 200) =~ "Show edge"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, edge_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    edge = Repo.insert! %Edge{}
    conn = get conn, edge_path(conn, :edit, edge)
    assert html_response(conn, 200) =~ "Edit edge"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    edge = Repo.insert! %Edge{}
    conn = put conn, edge_path(conn, :update, edge), edge: @valid_attrs
    assert redirected_to(conn) == edge_path(conn, :show, edge)
    assert Repo.get_by(Edge, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    edge = Repo.insert! %Edge{}
    conn = put conn, edge_path(conn, :update, edge), edge: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit edge"
  end

  test "deletes chosen resource", %{conn: conn} do
    edge = Repo.insert! %Edge{}
    conn = delete conn, edge_path(conn, :delete, edge)
    assert redirected_to(conn) == edge_path(conn, :index)
    refute Repo.get(Edge, edge.id)
  end
end
