defmodule PokemonWeb.PocketMonsterView do
  use PokemonWeb, :view
  alias PokemonWeb.PocketMonsterView

  def render("index.json", %{pocket_monsters: pocket_monsters}) do
    %{data: render_many(pocket_monsters, PocketMonsterView, "pocket_monster.json")}
  end

  def render("show.json", %{pocket_monster: pocket_monster}) do
    %{data: render_one(pocket_monster, PocketMonsterView, "pocket_monster.json")}
  end

  def render("pocket_monster.json", %{pocket_monster: pocket_monster}) do
    %{
      id: pocket_monster.id,
      name: pocket_monster.name,
      pokeapi_id: pocket_monster.pokeapi_id,
      response: pocket_monster.response
    }
  end
end
