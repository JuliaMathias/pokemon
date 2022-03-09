defmodule Pokemon.Pokemons.PokemonRepositoryTest do
  @moduledoc false
  use ExUnit.Case, async: true

  import Mox

  alias Pokemon.Pokemons.PokemonRepository

  setup :verify_on_exit!

  test "gets name of a pokemon when given an id" do
    expect(PokeApiBehaviourMock, :get_by_id, fn _id -> {:ok, %{"name" => "ditto"}} end)

    assert PokemonRepository.get_name_by_id("132") == "ditto"
  end

  test "gets id of a pokemon when given a name" do
    expect(PokeApiBehaviourMock, :get_by_name, fn _name -> {:ok, %{"id" => 132}} end)

    assert PokemonRepository.get_id_by_name("ditto") == 132
  end

  test "when id is given and the pokemon is not found return {:error, :not_found}" do
    expect(PokeApiBehaviourMock, :get_by_id, fn _id -> {:error, :not_found} end)

    assert PokemonRepository.get_name_by_id("9999999") == {:error, :not_found}
  end

  test "when name is given and the pokemon is not found return {:error, :not_found}" do
    expect(PokeApiBehaviourMock, :get_by_name, fn _name -> {:error, :not_found} end)

    assert PokemonRepository.get_id_by_name("julia") == {:error, :not_found}
  end

  test "if api is unavailable should return {:error, :unexpected}" do
    expect(PokeApiBehaviourMock, :get_by_id, fn _id -> {:error, :unexpected} end)

    assert PokemonRepository.get_name_by_id("132") == {:error, :unexpected}

    expect(PokeApiBehaviourMock, :get_by_name, fn _name -> {:error, :unexpected} end)

    assert PokemonRepository.get_id_by_name("ditto") == {:error, :unexpected}
  end
end
