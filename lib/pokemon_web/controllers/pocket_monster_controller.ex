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

  # def show(conn, %{"id" => id}) do
  #   pocket_monster = PocketMonsters.get_pocket_monster!(id)
  #   render(conn, "show.json", pocket_monster: pocket_monster)
  # end
end
