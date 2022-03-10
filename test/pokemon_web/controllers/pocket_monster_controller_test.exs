defmodule PokemonWeb.PocketMonsterControllerTest do
  @moduledoc false
  use PokemonWeb.ConnCase

  import Mox

  # alias Pokemon.PocketMonsters.PocketMonster

  @pokeapi_id "132"
  @name "ditto"
  @response %{"name" => @name, "id" => 132}

  setup :verify_on_exit!

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "name" do
    test "gets pocket monster name using pokeapi_id", %{conn: conn} do
      expect(PokeApiBehaviourMock, :get_by_id, fn _id -> {:ok, @response} end)

      conn = get(conn, Routes.pocket_monster_path(conn, :name, @pokeapi_id))
      assert %{"name" => @name} = json_response(conn, 200)["data"]
    end

    test "returns 404 if pocket monster is not found", %{conn: conn} do
      expect(PokeApiBehaviourMock, :get_by_id, fn _id -> {:error, :not_found} end)

      conn = get(conn, Routes.pocket_monster_path(conn, :name, @pokeapi_id))
      assert json_response(conn, 404) == "Not Found"
    end

    test "returns 500 if there's an unexpected error", %{conn: conn} do
      expect(PokeApiBehaviourMock, :get_by_id, fn _id -> {:error, :unexpected} end)

      conn = get(conn, Routes.pocket_monster_path(conn, :name, @pokeapi_id))
      assert json_response(conn, 500) == "Internal Server Error"
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
