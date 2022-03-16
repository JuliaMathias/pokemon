defmodule Pokemon.PocketMonstersTest do
  @moduledoc false
  use ExUnit.Case, async: true

  import Ecto.Query
  import Hammox

  alias Ecto.Adapters.SQL.Sandbox
  alias Pokemon.PocketMonsters
  alias Pokemon.PocketMonsters.PocketMonster
  alias Pokemon.Repo

  setup :verify_on_exit!

  setup do
    :ok = Sandbox.checkout(Repo)
  end

  describe "using the database" do
    setup do
      id = "8"
      name = "wartortle"

      Repo.insert(%PocketMonster{
        pokeapi_id: id,
        name: name,
        response: %{"name" => name, "id" => 8}
      })

      {:ok, %{id: id, name: name}}
    end

    test "gets name of a pokemon when given an id", %{id: id, name: name} do
      assert PocketMonsters.get_name_by_id(id) == name
    end

    test "gets id of a pokemon when given a name", %{id: id, name: name} do
      assert PocketMonsters.get_id_by_name(name) == id
    end
  end

  describe "using the api" do
    test "gets name of a pokemon when given an id and saves to database" do
      id = "132"
      name = "ditto"
      response = %{"name" => name, "id" => 132}

      expect(PokeApiBehaviourMock, :get_by_id, fn ^id -> {:ok, response} end)

      assert PocketMonsters.get_name_by_id(id) == name

      pokemon = Repo.one(from p in PocketMonster, where: p.pokeapi_id == ^id)

      assert pokemon.pokeapi_id == id
      assert pokemon.name == name
      assert pokemon.response == response
    end

    test "gets id of a pokemon when given a name and saves to database" do
      id = "15"
      name = "beedrill"
      response = %{"name" => name, "id" => 15}

      expect(PokeApiBehaviourMock, :get_by_name, fn ^name -> {:ok, response} end)

      assert PocketMonsters.get_id_by_name(name) == id

      pokemon = Repo.one(from p in PocketMonster, where: p.name == ^name)

      assert pokemon.pokeapi_id == id
      assert pokemon.name == name
      assert pokemon.response == response
    end
  end

  test "when id is given and the pokemon is not found return {:error, :not_found}" do
    id = "9999999"

    expect(PokeApiBehaviourMock, :get_by_id, fn ^id -> {:error, :not_found} end)

    assert PocketMonsters.get_name_by_id(id) == {:error, :not_found}
  end

  test "when name is given and the pokemon is not found return {:error, :not_found}" do
    name = "julia"

    expect(PokeApiBehaviourMock, :get_by_name, fn ^name -> {:error, :not_found} end)

    assert PocketMonsters.get_id_by_name(name) == {:error, :not_found}
  end

  test "if api is unavailable should return {:error, :unexpected}" do
    id = "132"
    name = "ditto"

    expect(PokeApiBehaviourMock, :get_by_id, fn ^id -> {:error, :unexpected} end)

    assert PocketMonsters.get_name_by_id(id) == {:error, :unexpected}

    expect(PokeApiBehaviourMock, :get_by_name, fn ^name -> {:error, :unexpected} end)

    assert PocketMonsters.get_id_by_name(name) == {:error, :unexpected}
  end
end
