defmodule Offshore.IntermediaryControllerTest do
  use Offshore.ConnCase

  alias Offshore.Intermediary
  @valid_attrs %{address: "some content", countries: "some content", country_codes: "some content", internal_id: 42, name: "some content", node_id: 42, sourceID: "some content", status: "some content", valid_until: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, intermediary_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing intermediaries"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, intermediary_path(conn, :new)
    assert html_response(conn, 200) =~ "New intermediary"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, intermediary_path(conn, :create), intermediary: @valid_attrs
    assert redirected_to(conn) == intermediary_path(conn, :index)
    assert Repo.get_by(Intermediary, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, intermediary_path(conn, :create), intermediary: @invalid_attrs
    assert html_response(conn, 200) =~ "New intermediary"
  end

  test "shows chosen resource", %{conn: conn} do
    intermediary = Repo.insert! %Intermediary{}
    conn = get conn, intermediary_path(conn, :show, intermediary)
    assert html_response(conn, 200) =~ "Show intermediary"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, intermediary_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    intermediary = Repo.insert! %Intermediary{}
    conn = get conn, intermediary_path(conn, :edit, intermediary)
    assert html_response(conn, 200) =~ "Edit intermediary"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    intermediary = Repo.insert! %Intermediary{}
    conn = put conn, intermediary_path(conn, :update, intermediary), intermediary: @valid_attrs
    assert redirected_to(conn) == intermediary_path(conn, :show, intermediary)
    assert Repo.get_by(Intermediary, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    intermediary = Repo.insert! %Intermediary{}
    conn = put conn, intermediary_path(conn, :update, intermediary), intermediary: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit intermediary"
  end

  test "deletes chosen resource", %{conn: conn} do
    intermediary = Repo.insert! %Intermediary{}
    conn = delete conn, intermediary_path(conn, :delete, intermediary)
    assert redirected_to(conn) == intermediary_path(conn, :index)
    refute Repo.get(Intermediary, intermediary.id)
  end
end
