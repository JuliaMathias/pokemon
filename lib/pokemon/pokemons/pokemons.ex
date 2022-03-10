defmodule Pokemon.Pokemons.Pokemons do
  @moduledoc """
  Functions that deal with our lovely Pokemons
  """

  import Ecto.Query

  alias Pokemon.Pokemons.PokemonSchema
  alias Pokemon.Repo

  @spec get_name_by_id(id :: String.t()) :: String.t() | {:error, atom}
  def get_name_by_id(id) do
    with nil <- Repo.one(from p in PokemonSchema, where: p.pokeapi_id == ^id),
         {:ok, pokemon} <- impl().get_by_id(id),
         {:ok, %PokemonSchema{name: name}} <- save_pokemon(pokemon) do
      name
    else
      %PokemonSchema{name: name} -> name
      error -> error
    end
  end

  @spec get_id_by_name(name :: String.t()) :: String.t() | {:error, atom}
  def get_id_by_name(name) do
    with nil <- Repo.one(from p in PokemonSchema, where: p.name == ^name),
         {:ok, pokemon} <- impl().get_by_name(name),
         {:ok, %PokemonSchema{pokeapi_id: pokeapi_id}} <- save_pokemon(pokemon) do
      pokeapi_id
    else
      %PokemonSchema{pokeapi_id: id} -> id
      error -> error
    end
  end

  defp save_pokemon(%{"name" => name, "id" => id} = pokemon) do
    Repo.insert(%PokemonSchema{pokeapi_id: Integer.to_string(id), name: name, response: pokemon})
  end

  defp impl, do: Application.get_env(:pokemon, __MODULE__, Pokemon.PokeApi.Client)
end
