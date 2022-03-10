defmodule PokemonWeb.PocketMonsterController do
  use PokemonWeb, :controller

  alias Pokemon.PocketMonsters

  action_fallback PokemonWeb.FallbackController

  def name(conn, %{"pokeapi_id" => pokeapi_id}) do
    with pocket_monster_name when is_binary(pocket_monster_name) <-
           PocketMonsters.get_name_by_id(pokeapi_id) do
      render(conn, "name.json", pocket_monster_name: pocket_monster_name)
    end
  end

  def pokeapi_id(conn, %{"name" => name}) do
    with pocket_monster_pokeapi_id when is_binary(pocket_monster_pokeapi_id) <-
           PocketMonsters.get_id_by_name(name) do
      render(conn, "pokeapi_id.json", pocket_monster_pokeapi_id: pocket_monster_pokeapi_id)
    end
  end
end
