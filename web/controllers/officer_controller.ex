defmodule Offshore.OfficerController do
  use Offshore.Web, :controller

  alias Offshore.Officer

  def index(conn, _params) do
    officers = Repo.all(Officer)
    render(conn, "index.html", officers: officers)
  end

  def new(conn, _params) do
    changeset = Officer.changeset(%Officer{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"officer" => officer_params}) do
    changeset = Officer.changeset(%Officer{}, officer_params)

    case Repo.insert(changeset) do
      {:ok, _officer} ->
        conn
        |> put_flash(:info, "Officer created successfully.")
        |> redirect(to: officer_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    officer = Repo.get!(Officer, id)
    render(conn, "show.html", officer: officer)
  end

  def edit(conn, %{"id" => id}) do
    officer = Repo.get!(Officer, id)
    changeset = Officer.changeset(officer)
    render(conn, "edit.html", officer: officer, changeset: changeset)
  end

  def update(conn, %{"id" => id, "officer" => officer_params}) do
    officer = Repo.get!(Officer, id)
    changeset = Officer.changeset(officer, officer_params)

    case Repo.update(changeset) do
      {:ok, officer} ->
        conn
        |> put_flash(:info, "Officer updated successfully.")
        |> redirect(to: officer_path(conn, :show, officer))
      {:error, changeset} ->
        render(conn, "edit.html", officer: officer, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    officer = Repo.get!(Officer, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(officer)

    conn
    |> put_flash(:info, "Officer deleted successfully.")
    |> redirect(to: officer_path(conn, :index))
  end
end
