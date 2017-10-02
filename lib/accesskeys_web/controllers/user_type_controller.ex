defmodule AccesskeysWeb.UserTypeController do
  use AccesskeysWeb, :controller

  alias Accesskeys.Accounts
  alias Accesskeys.Accounts.UserType

  def index(conn, _params) do
    user_types = Accounts.list_user_types()
    render(conn, "index.html", user_types: user_types)
  end

  def new(conn, _params) do
    # Get an Array of strings of the valid actions in the system
    valid_user_actions = valid_user_actions_checkbox_list

    changeset = Accounts.change_user_type(%UserType{})

    render(conn, "new.html", changeset: changeset, valid_user_actions: valid_user_actions)
  end

  def create(conn, %{"user_type" => user_type_params}) do
    # Fallback if we have to go back to the :new page
    valid_user_actions = valid_user_actions_checkbox_list

    # Turn the selected actions into just an array of strings
    checked_actions = filter_and_map_checked_actions(conn.params["checked_actions"])

    # Add the filtered string array to the user_params
    user_type_params = Map.put(user_type_params, "actions", checked_actions)

    case Accounts.create_user_type(user_type_params) do
      {:ok, user_type} ->
        conn
        |> put_flash(:info, "User type created successfully.")
        |> redirect(to: user_type_path(conn, :show, user_type))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, valid_user_actions: valid_user_actions)
    end
  end

  def show(conn, %{"id" => id}) do
    user_type = Accounts.get_user_type!(id)
    render(conn, "show.html", user_type: user_type)
  end

  def edit(conn, %{"id" => id}) do
    user_type = Accounts.get_user_type!(id)

    #Create checkbox list with boxes pre-checked based on the current user_type
    currently_selected_user_actions = get_selected_actions(user_type.actions)

    changeset = Accounts.change_user_type(user_type)
    render(conn, "edit.html", user_type: user_type, changeset: changeset, valid_user_actions: currently_selected_user_actions)
  end

  def update(conn, %{"id" => id, "user_type" => user_type_params}) do
    user_type = Accounts.get_user_type!(id)

    # Fallback if we have to go back to the :edit page
    currently_selected_user_actions = get_selected_actions(user_type.actions)

    checked_actions = filter_and_map_checked_actions(conn.params["checked_actions"])
    user_type_params = Map.put(user_type_params, "actions", checked_actions)


    case Accounts.update_user_type(user_type, user_type_params) do
      {:ok, user_type} ->
        conn
        |> put_flash(:info, "User type updated successfully.")
        |> redirect(to: user_type_path(conn, :show, user_type))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user_type: user_type, changeset: changeset, valid_user_actions: currently_selected_user_actions)
    end
  end

  def delete(conn, %{"id" => id}) do
    user_type = Accounts.get_user_type!(id)
    {:ok, _user_type} = Accounts.delete_user_type(user_type)

    conn
    |> put_flash(:info, "User type deleted successfully.")
    |> redirect(to: user_type_path(conn, :index))
  end


  defp valid_user_actions_checkbox_list do
    Accounts.valid_user_actions()
    |> Enum.map(fn x -> %{action: x, isChecked: false} end)
  end

  # Creates a checkbox list (action:string, isChecked:boolean) from 
  defp get_selected_actions(current_actions) do
     Accounts.valid_user_actions()
     |> Enum.map(fn valid_action -> 
        %{
          action: valid_action,
          isChecked: Enum.any?(current_actions, fn(current_action) -> 
            current_action == valid_action 
            end
            )}
        end
      )
  end

    defp filter_and_map_checked_actions(checked_actions) do
    checked_actions
     |> Enum.filter(fn {x,y} -> y == "true" end) 
     |> Enum.map(fn {x,y} -> x end)
  end


end
