defmodule Accesskeys.Repo.Migrations.CreateAccessKeys do
  use Ecto.Migration

  def change do
    create table(:access_keys) do
      add :access_key, :string
      add :user_type_id, references(:user_types, on_delete: :nothing)

      timestamps()
    end

    create index(:access_keys, [:user_type_id])
  end
end
