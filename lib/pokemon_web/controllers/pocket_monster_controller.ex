defmodule PokemonWeb.PocketMonsterController do
  use PokemonWeb, :controller

  alias Pokemon.PocketMonsters
  # alias Pokemon.PocketMonsters.PocketMonster

  action_fallback PokemonWeb.FallbackController

  def name(conn, %{"pokeapi_id" => pokeapi_id}) do
    pocket_monster_name = PocketMonsters.get_name_by_id(pokeapi_id)
    render(conn, "name.json", pocket_monster_name: pocket_monster_name)
  end

  # def index(conn, _params) do
  #   pocket_monsters = PocketMonsters.list_pocket_monsters()
  #   render(conn, "index.json", pocket_monsters: pocket_monsters)
  # end

  # def create(conn, %{"pocket_monster" => pocket_monster_params}) do
  #   with {:ok, %PocketMonster{} = pocket_monster} <- PocketMonsters.create_pocket_monster(pocket_monster_params) do
  #     conn
  #     |> put_status(:created)
  #     |> put_resp_header("location", Routes.pocket_monster_path(conn, :show, pocket_monster))
  #     |> render("show.json", pocket_monster: pocket_monster)
  #   end
  # end

  # def show(conn, %{"id" => id}) do
  #   pocket_monster = PocketMonsters.get_pocket_monster!(id)
  #   render(conn, "show.json", pocket_monster: pocket_monster)
  # end

  # def update(conn, %{"id" => id, "pocket_monster" => pocket_monster_params}) do
  #   pocket_monster = PocketMonsters.get_pocket_monster!(id)

  #   with {:ok, %PocketMonster{} = pocket_monster} <- PocketMonsters.update_pocket_monster(pocket_monster, pocket_monster_params) do
  #     render(conn, "show.json", pocket_monster: pocket_monster)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   pocket_monster = PocketMonsters.get_pocket_monster!(id)

  #   with {:ok, %PocketMonster{}} <- PocketMonsters.delete_pocket_monster(pocket_monster) do
  #     send_resp(conn, :no_content, "")
  #   end
  # end
end
