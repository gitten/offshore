defmodule Offshore.EntityControllerTest do
  use Offshore.ConnCase

  alias Offshore.Entity
  @valid_attrs %{address: "some content", company_type: "some content", countries: "some content", country_codes: "some content", dorm_date: %{day: 17, month: 4, year: 2010}, former_name: "some content", ibcRUC: "some content", inactivation_date: %{day: 17, month: 4, year: 2010}, incorporation_date: %{day: 17, month: 4, year: 2010}, internal_id: "some content", jurisdiction: "some content", jurisdiction_description: "some content", name: "some content", node_id: 42, note: "some content", original_name: "some content", service_provider: "some content", sourceID: "some content", status: "some content", struck_off_date: %{day: 17, month: 4, year: 2010}, valid_until: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, entity_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing entities"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, entity_path(conn, :new)
    assert html_response(conn, 200) =~ "New entity"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, entity_path(conn, :create), entity: @valid_attrs
    assert redirected_to(conn) == entity_path(conn, :index)
    assert Repo.get_by(Entity, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, entity_path(conn, :create), entity: @invalid_attrs
    assert html_response(conn, 200) =~ "New entity"
  end

  test "shows chosen resource", %{conn: conn} do
    entity = Repo.insert! %Entity{}
    conn = get conn, entity_path(conn, :show, entity)
    assert html_response(conn, 200) =~ "Show entity"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, entity_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    entity = Repo.insert! %Entity{}
    conn = get conn, entity_path(conn, :edit, entity)
    assert html_response(conn, 200) =~ "Edit entity"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    entity = Repo.insert! %Entity{}
    conn = put conn, entity_path(conn, :update, entity), entity: @valid_attrs
    assert redirected_to(conn) == entity_path(conn, :show, entity)
    assert Repo.get_by(Entity, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    entity = Repo.insert! %Entity{}
    conn = put conn, entity_path(conn, :update, entity), entity: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit entity"
  end

  test "deletes chosen resource", %{conn: conn} do
    entity = Repo.insert! %Entity{}
    conn = delete conn, entity_path(conn, :delete, entity)
    assert redirected_to(conn) == entity_path(conn, :index)
    refute Repo.get(Entity, entity.id)
  end
end
