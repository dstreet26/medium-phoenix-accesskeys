defmodule AccesskeysWeb.UserController do
  use AccesskeysWeb, :controller

  alias Accesskeys.Accounts
  alias Accesskeys.Accounts.User

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    user_types = Accounts.list_user_types()
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    # Get the access key from the params
    access_key = user_params["access_key"]
    # Check if it exists
    database_key = Accounts.check_access_key!(access_key)

    case database_key do
      nil ->
        conn
          |> put_flash(:error, "Access Key not found.")
          |> redirect(to: user_path(conn, :index))
      _ ->
        user_type_id = database_key.user_type_id
        case Accounts.create_user(user_params, user_type_id) do
          {:ok, user} ->
            Accounts.delete_access_key(database_key)
            conn
            |> put_flash(:info, "User created successfully.")
            |> redirect(to: user_path(conn, :show, user))
          {:error, %Ecto.Changeset{} = changeset} ->
            render(conn, "new.html", changeset: changeset)
        end
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.html", user: user)
  end

  def edit(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    changeset = Accounts.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    case Accounts.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    {:ok, _user} = Accounts.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: user_path(conn, :index))
  end
end
