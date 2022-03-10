defmodule PokemonWeb.PocketMonsterControllerTest do
  @moduledoc false
  use PokemonWeb.ConnCase

  import Mox

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

  describe "pokeapi_id" do
    test "gets pocket monster pokeapi_id using name", %{conn: conn} do
      expect(PokeApiBehaviourMock, :get_by_name, fn _id -> {:ok, @response} end)

      conn = get(conn, Routes.pocket_monster_path(conn, :pokeapi_id, @name))
      assert %{"pokeapi_id" => @pokeapi_id} = json_response(conn, 200)["data"]
    end

    test "returns 404 if pocket monster is not found", %{conn: conn} do
      expect(PokeApiBehaviourMock, :get_by_name, fn _id -> {:error, :not_found} end)

      conn = get(conn, Routes.pocket_monster_path(conn, :pokeapi_id, @name))
      assert json_response(conn, 404) == "Not Found"
    end

    test "returns 500 if there's an unexpected error", %{conn: conn} do
      expect(PokeApiBehaviourMock, :get_by_name, fn _id -> {:error, :unexpected} end)

      conn = get(conn, Routes.pocket_monster_path(conn, :pokeapi_id, @name))
      assert json_response(conn, 500) == "Internal Server Error"
    end
  end
end
