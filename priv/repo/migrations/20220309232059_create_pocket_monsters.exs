defmodule Pokemon.Repo.Migrations.CreatePocketMonsters do
  use Ecto.Migration

  def change do
    create table(:pocket_monsters, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :pokeapi_id, :string
      add :response, :map, default: %{}

      timestamps()
    end
  end
end
