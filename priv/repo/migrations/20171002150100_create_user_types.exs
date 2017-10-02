defmodule Accesskeys.Repo.Migrations.CreateUserTypes do
  use Ecto.Migration

  def change do
    create table(:user_types) do
      add :type, :string
      add :actions, {:array, :string}

      timestamps()
    end

    create unique_index(:user_types, [:type])
  end
end
