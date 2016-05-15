defmodule Offshore.EdgeController do
  use Offshore.Web, :controller

  alias Offshore.Edge

  def index(conn, _params) do
    edges = Repo.all(Edge)
    render(conn, "index.html", edges: edges)
  end

  def new(conn, _params) do
    changeset = Edge.changeset(%Edge{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"edge" => edge_params}) do
    changeset = Edge.changeset(%Edge{}, edge_params)

    case Repo.insert(changeset) do
      {:ok, _edge} ->
        conn
        |> put_flash(:info, "Edge created successfully.")
        |> redirect(to: edge_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    edge = Repo.get!(Edge, id)
    render(conn, "show.html", edge: edge)
  end

  def edit(conn, %{"id" => id}) do
    edge = Repo.get!(Edge, id)
    changeset = Edge.changeset(edge)
    render(conn, "edit.html", edge: edge, changeset: changeset)
  end

  def update(conn, %{"id" => id, "edge" => edge_params}) do
    edge = Repo.get!(Edge, id)
    changeset = Edge.changeset(edge, edge_params)

    case Repo.update(changeset) do
      {:ok, edge} ->
        conn
        |> put_flash(:info, "Edge updated successfully.")
        |> redirect(to: edge_path(conn, :show, edge))
      {:error, changeset} ->
        render(conn, "edit.html", edge: edge, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    edge = Repo.get!(Edge, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(edge)

    conn
    |> put_flash(:info, "Edge deleted successfully.")
    |> redirect(to: edge_path(conn, :index))
  end
end
