defmodule PokemonWeb.PocketMonsterControllerTest do
  use PokemonWeb.ConnCase

  import Pokemon.PocketMonstersFixtures

  alias Pokemon.PocketMonsters.PocketMonster

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

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all pocket_monsters", %{conn: conn} do
      conn = get(conn, Routes.pocket_monster_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create pocket_monster" do
    test "renders pocket_monster when data is valid", %{conn: conn} do
      conn = post(conn, Routes.pocket_monster_path(conn, :create), pocket_monster: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.pocket_monster_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "name" => "some name",
               "pokeapi_id" => "some pokeapi_id",
               "response" => %{}
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.pocket_monster_path(conn, :create), pocket_monster: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update pocket_monster" do
    setup [:create_pocket_monster]

    test "renders pocket_monster when data is valid", %{conn: conn, pocket_monster: %PocketMonster{id: id} = pocket_monster} do
      conn = put(conn, Routes.pocket_monster_path(conn, :update, pocket_monster), pocket_monster: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.pocket_monster_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "name" => "some updated name",
               "pokeapi_id" => "some updated pokeapi_id",
               "response" => %{}
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, pocket_monster: pocket_monster} do
      conn = put(conn, Routes.pocket_monster_path(conn, :update, pocket_monster), pocket_monster: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete pocket_monster" do
    setup [:create_pocket_monster]

    test "deletes chosen pocket_monster", %{conn: conn, pocket_monster: pocket_monster} do
      conn = delete(conn, Routes.pocket_monster_path(conn, :delete, pocket_monster))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.pocket_monster_path(conn, :show, pocket_monster))
      end
    end
  end

  defp create_pocket_monster(_) do
    pocket_monster = pocket_monster_fixture()
    %{pocket_monster: pocket_monster}
  end
end
