defmodule Offshore.IntermediaryController do
  use Offshore.Web, :controller

  alias Offshore.Intermediary

  def index(conn, _params) do
    intermediaries = Repo.all(Intermediary)
    render(conn, "index.html", intermediaries: intermediaries)
  end

  def new(conn, _params) do
    changeset = Intermediary.changeset(%Intermediary{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"intermediary" => intermediary_params}) do
    changeset = Intermediary.changeset(%Intermediary{}, intermediary_params)

    case Repo.insert(changeset) do
      {:ok, _intermediary} ->
        conn
        |> put_flash(:info, "Intermediary created successfully.")
        |> redirect(to: intermediary_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    intermediary = Repo.get!(Intermediary, id)
    render(conn, "show.html", intermediary: intermediary)
  end

  def edit(conn, %{"id" => id}) do
    intermediary = Repo.get!(Intermediary, id)
    changeset = Intermediary.changeset(intermediary)
    render(conn, "edit.html", intermediary: intermediary, changeset: changeset)
  end

  def update(conn, %{"id" => id, "intermediary" => intermediary_params}) do
    intermediary = Repo.get!(Intermediary, id)
    changeset = Intermediary.changeset(intermediary, intermediary_params)

    case Repo.update(changeset) do
      {:ok, intermediary} ->
        conn
        |> put_flash(:info, "Intermediary updated successfully.")
        |> redirect(to: intermediary_path(conn, :show, intermediary))
      {:error, changeset} ->
        render(conn, "edit.html", intermediary: intermediary, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    intermediary = Repo.get!(Intermediary, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(intermediary)

    conn
    |> put_flash(:info, "Intermediary deleted successfully.")
    |> redirect(to: intermediary_path(conn, :index))
  end
end
