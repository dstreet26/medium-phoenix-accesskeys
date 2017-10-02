defmodule Accesskeys.Accounts.AccessKey do
  use Ecto.Schema
  import Ecto.Changeset
  alias Accesskeys.Accounts.{AccessKey,UserType}


  schema "access_keys" do
    field :access_key, :string
    belongs_to :user_type, UserType

    timestamps()
  end

  @doc false
  def changeset(%AccessKey{} = access_key, attrs) do
    access_key
    |> cast(attrs, [:access_key])
    |> validate_required([:access_key])
  end
end
