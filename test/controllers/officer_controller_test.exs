defmodule Offshore.OfficerControllerTest do
  use Offshore.ConnCase

  alias Offshore.Officer
  @valid_attrs %{countries: "some content", country_codes: "some content", icij_id: "some content", name: "some content", node_id: 42, sourceID: "some content", valid_until: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, officer_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing officers"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, officer_path(conn, :new)
    assert html_response(conn, 200) =~ "New officer"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, officer_path(conn, :create), officer: @valid_attrs
    assert redirected_to(conn) == officer_path(conn, :index)
    assert Repo.get_by(Officer, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, officer_path(conn, :create), officer: @invalid_attrs
    assert html_response(conn, 200) =~ "New officer"
  end

  test "shows chosen resource", %{conn: conn} do
    officer = Repo.insert! %Officer{}
    conn = get conn, officer_path(conn, :show, officer)
    assert html_response(conn, 200) =~ "Show officer"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, officer_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    officer = Repo.insert! %Officer{}
    conn = get conn, officer_path(conn, :edit, officer)
    assert html_response(conn, 200) =~ "Edit officer"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    officer = Repo.insert! %Officer{}
    conn = put conn, officer_path(conn, :update, officer), officer: @valid_attrs
    assert redirected_to(conn) == officer_path(conn, :show, officer)
    assert Repo.get_by(Officer, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    officer = Repo.insert! %Officer{}
    conn = put conn, officer_path(conn, :update, officer), officer: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit officer"
  end

  test "deletes chosen resource", %{conn: conn} do
    officer = Repo.insert! %Officer{}
    conn = delete conn, officer_path(conn, :delete, officer)
    assert redirected_to(conn) == officer_path(conn, :index)
    refute Repo.get(Officer, officer.id)
  end
end
