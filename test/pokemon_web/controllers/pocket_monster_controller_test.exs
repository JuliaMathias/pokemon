defmodule PokemonWeb.PocketMonsterControllerTest do
  use PokemonWeb.ConnCase

  import Mox

  alias Pokemon.PocketMonsters.PocketMonster

  @pokeapi_id "132"
  @name "ditto"
  @response %{"name" => @name, "id" => 132}

  @create_attrs %{
    name: "some name",
    pokeapi_id: "some pokeapi_id",
    response: %{}
  }
  @update_attrs %{
    name: "some updated name",
    pokeapi_id: "some updated pokeapi_id",
    response: %{}
  }
  @invalid_attrs %{name: nil, pokeapi_id: nil, response: nil}

  setup :verify_on_exit!

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "name" do
    test "gets pokemon name using pokeapi_id", %{conn: conn} do
      expect(PokeApiBehaviourMock, :get_by_id, fn _id -> {:ok, @response} end)

      conn = get(conn, Routes.pocket_monster_path(conn, :name, @pokeapi_id))
      assert %{"name" => @name} = json_response(conn, 200)["data"]
    end
  end

  # describe "update pocket_monster" do
  #   setup [:create_pocket_monster]

  #   test "renders pocket_monster when data is valid", %{
  #     conn: conn,
  #     pocket_monster: %PocketMonster{id: id} = pocket_monster
  #   } do
  #     conn =
  #       put(conn, Routes.pocket_monster_path(conn, :update, pocket_monster),
  #         pocket_monster: @update_attrs
  #       )

  #     assert %{"id" => ^id} = json_response(conn, 200)["data"]

  #     conn = get(conn, Routes.pocket_monster_path(conn, :show, id))

  #     assert %{
  #              "id" => ^id,
  #              "name" => "some updated name",
  #              "pokeapi_id" => "some updated pokeapi_id",
  #              "response" => %{}
  #            } = json_response(conn, 200)["data"]
  #   end

  #   test "renders errors when data is invalid", %{conn: conn, pocket_monster: pocket_monster} do
  #     conn =
  #       put(conn, Routes.pocket_monster_path(conn, :update, pocket_monster),
  #         pocket_monster: @invalid_attrs
  #       )

  #     assert json_response(conn, 422)["errors"] != %{}
  #   end
  # end
end
