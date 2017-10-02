defmodule Accesskeys.Accounts.AccessKey do
  use Ecto.Schema
  import Ecto.Changeset
  alias Accesskeys.Accounts.AccessKey


  schema "access_keys" do
    field :access_key, :string
    field :user_type_id, :id

    timestamps()
  end

  @doc false
  def changeset(%AccessKey{} = access_key, attrs) do
    access_key
    |> cast(attrs, [:access_key])
    |> validate_required([:access_key])
  end
end
