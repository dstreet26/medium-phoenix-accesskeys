defmodule AccesskeysWeb.AccessKeyControllerTest do
  use AccesskeysWeb.ConnCase

  alias Accesskeys.Accounts

  @create_attrs %{access_key: "some access_key"}
  @update_attrs %{access_key: "some updated access_key"}
  @invalid_attrs %{access_key: nil}

  def fixture(:access_key) do
    {:ok, access_key} = Accounts.create_access_key(@create_attrs)
    access_key
  end

  describe "index" do
    test "lists all access_keys", %{conn: conn} do
      conn = get conn, access_key_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Access keys"
    end
  end

  describe "new access_key" do
    test "renders form", %{conn: conn} do
      conn = get conn, access_key_path(conn, :new)
      assert html_response(conn, 200) =~ "New Access key"
    end
  end

  describe "create access_key" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, access_key_path(conn, :create), access_key: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == access_key_path(conn, :show, id)

      conn = get conn, access_key_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Access key"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, access_key_path(conn, :create), access_key: @invalid_attrs
      assert html_response(conn, 200) =~ "New Access key"
    end
  end

  describe "edit access_key" do
    setup [:create_access_key]

    test "renders form for editing chosen access_key", %{conn: conn, access_key: access_key} do
      conn = get conn, access_key_path(conn, :edit, access_key)
      assert html_response(conn, 200) =~ "Edit Access key"
    end
  end

  describe "update access_key" do
    setup [:create_access_key]

    test "redirects when data is valid", %{conn: conn, access_key: access_key} do
      conn = put conn, access_key_path(conn, :update, access_key), access_key: @update_attrs
      assert redirected_to(conn) == access_key_path(conn, :show, access_key)

      conn = get conn, access_key_path(conn, :show, access_key)
      assert html_response(conn, 200) =~ "some updated access_key"
    end

    test "renders errors when data is invalid", %{conn: conn, access_key: access_key} do
      conn = put conn, access_key_path(conn, :update, access_key), access_key: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Access key"
    end
  end

  describe "delete access_key" do
    setup [:create_access_key]

    test "deletes chosen access_key", %{conn: conn, access_key: access_key} do
      conn = delete conn, access_key_path(conn, :delete, access_key)
      assert redirected_to(conn) == access_key_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, access_key_path(conn, :show, access_key)
      end
    end
  end

  defp create_access_key(_) do
    access_key = fixture(:access_key)
    {:ok, access_key: access_key}
  end
end
