defmodule Pokemon.Repo.Migrations.CreatePokemons do
  use Ecto.Migration

  def change do
    create table(:pokemons) do
      add :name, :string
      add :pokeapi_id, :integer
      add :response, :map, default: %{}

      timestamps()
    end
  end
end
