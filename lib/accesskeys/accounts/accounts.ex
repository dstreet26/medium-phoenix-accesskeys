defmodule Accesskeys.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Accesskeys.Repo

  alias Accesskeys.Accounts.UserType


  def valid_user_actions do
    ["can_make_thumbnails",
      "can_add_users",
      "can_delete_users",
      "can_add_new_fields",
      "can_modify_fields",
      "can_view_high_res_image",
      "can_comment"
      ]
  end


  @doc """
  Returns the list of user_types.

  ## Examples

      iex> list_user_types()
      [%UserType{}, ...]

  """
  def list_user_types do
    Repo.all(UserType)
  end

  @doc """
  Gets a single user_type.

  Raises `Ecto.NoResultsError` if the User type does not exist.

  ## Examples

      iex> get_user_type!(123)
      %UserType{}

      iex> get_user_type!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user_type!(id), do: Repo.get!(UserType, id)

  @doc """
  Creates a user_type.

  ## Examples

      iex> create_user_type(%{field: value})
      {:ok, %UserType{}}

      iex> create_user_type(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user_type(attrs \\ %{}) do
    %UserType{}
    |> UserType.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user_type.

  ## Examples

      iex> update_user_type(user_type, %{field: new_value})
      {:ok, %UserType{}}

      iex> update_user_type(user_type, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user_type(%UserType{} = user_type, attrs) do
    user_type
    |> UserType.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a UserType.

  ## Examples

      iex> delete_user_type(user_type)
      {:ok, %UserType{}}

      iex> delete_user_type(user_type)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user_type(%UserType{} = user_type) do
    Repo.delete(user_type)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user_type changes.

  ## Examples

      iex> change_user_type(user_type)
      %Ecto.Changeset{source: %UserType{}}

  """
  def change_user_type(%UserType{} = user_type) do
    UserType.changeset(user_type, %{})
  end

  alias Accesskeys.Accounts.AccessKey

  @doc """
  Returns the list of access_keys.

  ## Examples

      iex> list_access_keys()
      [%AccessKey{}, ...]

  """
  def list_access_keys do
    Repo.all(AccessKey)
  end

  @doc """
  Gets a single access_key.

  Raises `Ecto.NoResultsError` if the Access key does not exist.

  ## Examples

      iex> get_access_key!(123)
      %AccessKey{}

      iex> get_access_key!(456)
      ** (Ecto.NoResultsError)

  """
  def get_access_key!(id), do: Repo.get!(AccessKey, id)

  @doc """
  Creates a access_key.

  ## Examples

      iex> create_access_key(%{field: value})
      {:ok, %AccessKey{}}

      iex> create_access_key(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_access_key(attrs \\ %{}) do
    %AccessKey{}
    |> AccessKey.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a access_key.

  ## Examples

      iex> update_access_key(access_key, %{field: new_value})
      {:ok, %AccessKey{}}

      iex> update_access_key(access_key, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_access_key(%AccessKey{} = access_key, attrs) do
    access_key
    |> AccessKey.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a AccessKey.

  ## Examples

      iex> delete_access_key(access_key)
      {:ok, %AccessKey{}}

      iex> delete_access_key(access_key)
      {:error, %Ecto.Changeset{}}

  """
  def delete_access_key(%AccessKey{} = access_key) do
    Repo.delete(access_key)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking access_key changes.

  ## Examples

      iex> change_access_key(access_key)
      %Ecto.Changeset{source: %AccessKey{}}

  """
  def change_access_key(%AccessKey{} = access_key) do
    AccessKey.changeset(access_key, %{})
  end

  alias Accesskeys.Accounts.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end
end
