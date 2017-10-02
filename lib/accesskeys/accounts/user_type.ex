defmodule Accesskeys.Accounts.UserType do
  use Ecto.Schema
  import Ecto.Changeset
  alias Accesskeys.Accounts.UserType


  schema "user_types" do
    field :actions, {:array, :string}
    field :type, :string

    timestamps()
  end

  @doc false
  def changeset(%UserType{} = user_type, attrs) do
    user_type
    |> cast(attrs, [:type, :actions])
    |> validate_required([:type, :actions])
    |> unique_constraint(:type)
  end
end
