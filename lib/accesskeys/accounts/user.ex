defmodule Accesskeys.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Accesskeys.Accounts.User


  schema "users" do
    field :email, :string
    field :encrypted_password, :string
    field :name, :string
    field :user_type_id, :id

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :email, :encrypted_password])
    |> validate_required([:name, :email, :encrypted_password])
    |> unique_constraint(:email)
  end
end
