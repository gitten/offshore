defmodule Offshore.EntityController do
  use Offshore.Web, :controller

  alias Offshore.Entity

  def index(conn, _params) do
    entities = Repo.all(Entity)
    render(conn, "index.html", entities: entities)
  end

  def new(conn, _params) do
    changeset = Entity.changeset(%Entity{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"entity" => entity_params}) do
    changeset = Entity.changeset(%Entity{}, entity_params)

    case Repo.insert(changeset) do
      {:ok, _entity} ->
        conn
        |> put_flash(:info, "Entity created successfully.")
        |> redirect(to: entity_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    entity = Repo.get!(Entity, id)
    render(conn, "show.html", entity: entity)
  end

  def edit(conn, %{"id" => id}) do
    entity = Repo.get!(Entity, id)
    changeset = Entity.changeset(entity)
    render(conn, "edit.html", entity: entity, changeset: changeset)
  end

  def update(conn, %{"id" => id, "entity" => entity_params}) do
    entity = Repo.get!(Entity, id)
    changeset = Entity.changeset(entity, entity_params)

    case Repo.update(changeset) do
      {:ok, entity} ->
        conn
        |> put_flash(:info, "Entity updated successfully.")
        |> redirect(to: entity_path(conn, :show, entity))
      {:error, changeset} ->
        render(conn, "edit.html", entity: entity, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    entity = Repo.get!(Entity, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(entity)

    conn
    |> put_flash(:info, "Entity deleted successfully.")
    |> redirect(to: entity_path(conn, :index))
  end
end
