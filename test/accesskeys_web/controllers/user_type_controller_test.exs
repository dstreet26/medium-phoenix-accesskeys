defmodule AccesskeysWeb.UserTypeControllerTest do
  use AccesskeysWeb.ConnCase

  alias Accesskeys.Accounts

  @create_attrs %{actions: [], type: "some type"}
  @update_attrs %{actions: [], type: "some updated type"}
  @invalid_attrs %{actions: nil, type: nil}

  def fixture(:user_type) do
    {:ok, user_type} = Accounts.create_user_type(@create_attrs)
    user_type
  end

  describe "index" do
    test "lists all user_types", %{conn: conn} do
      conn = get conn, user_type_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing User types"
    end
  end

  describe "new user_type" do
    test "renders form", %{conn: conn} do
      conn = get conn, user_type_path(conn, :new)
      assert html_response(conn, 200) =~ "New User type"
    end
  end

  describe "create user_type" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, user_type_path(conn, :create), user_type: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == user_type_path(conn, :show, id)

      conn = get conn, user_type_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show User type"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, user_type_path(conn, :create), user_type: @invalid_attrs
      assert html_response(conn, 200) =~ "New User type"
    end
  end

  describe "edit user_type" do
    setup [:create_user_type]

    test "renders form for editing chosen user_type", %{conn: conn, user_type: user_type} do
      conn = get conn, user_type_path(conn, :edit, user_type)
      assert html_response(conn, 200) =~ "Edit User type"
    end
  end

  describe "update user_type" do
    setup [:create_user_type]

    test "redirects when data is valid", %{conn: conn, user_type: user_type} do
      conn = put conn, user_type_path(conn, :update, user_type), user_type: @update_attrs
      assert redirected_to(conn) == user_type_path(conn, :show, user_type)

      conn = get conn, user_type_path(conn, :show, user_type)
      assert html_response(conn, 200) =~ ""
    end

    test "renders errors when data is invalid", %{conn: conn, user_type: user_type} do
      conn = put conn, user_type_path(conn, :update, user_type), user_type: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit User type"
    end
  end

  describe "delete user_type" do
    setup [:create_user_type]

    test "deletes chosen user_type", %{conn: conn, user_type: user_type} do
      conn = delete conn, user_type_path(conn, :delete, user_type)
      assert redirected_to(conn) == user_type_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, user_type_path(conn, :show, user_type)
      end
    end
  end

  defp create_user_type(_) do
    user_type = fixture(:user_type)
    {:ok, user_type: user_type}
  end
end
