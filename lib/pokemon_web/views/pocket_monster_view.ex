defmodule PokemonWeb.PocketMonsterView do
  use PokemonWeb, :view

  def render("name.json", %{pocket_monster_name: pocket_monster_name}),
    do: %{data: %{name: pocket_monster_name}}

  def render("pokeapi_id.json", %{pocket_monster_pokeapi_id: pocket_monster_pokeapi_id}) do
    %{data: %{pokeapi_id: pocket_monster_pokeapi_id}}
  end
end
