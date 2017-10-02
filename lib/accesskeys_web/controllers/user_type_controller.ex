defmodule AccesskeysWeb.UserTypeController do
  use AccesskeysWeb, :controller

  alias Accesskeys.Accounts
  alias Accesskeys.Accounts.UserType

  def index(conn, _params) do
    user_types = Accounts.list_user_types()
    render(conn, "index.html", user_types: user_types)
  end

  def new(conn, _params) do
    changeset = Accounts.change_user_type(%UserType{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user_type" => user_type_params}) do
    case Accounts.create_user_type(user_type_params) do
      {:ok, user_type} ->
        conn
        |> put_flash(:info, "User type created successfully.")
        |> redirect(to: user_type_path(conn, :show, user_type))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user_type = Accounts.get_user_type!(id)
    render(conn, "show.html", user_type: user_type)
  end

  def edit(conn, %{"id" => id}) do
    user_type = Accounts.get_user_type!(id)
    changeset = Accounts.change_user_type(user_type)
    render(conn, "edit.html", user_type: user_type, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user_type" => user_type_params}) do
    user_type = Accounts.get_user_type!(id)

    case Accounts.update_user_type(user_type, user_type_params) do
      {:ok, user_type} ->
        conn
        |> put_flash(:info, "User type updated successfully.")
        |> redirect(to: user_type_path(conn, :show, user_type))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user_type: user_type, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user_type = Accounts.get_user_type!(id)
    {:ok, _user_type} = Accounts.delete_user_type(user_type)

    conn
    |> put_flash(:info, "User type deleted successfully.")
    |> redirect(to: user_type_path(conn, :index))
  end
end
