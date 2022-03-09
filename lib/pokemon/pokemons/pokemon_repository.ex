defmodule Pokemon.Pokemons.PokemonRepository do
  @moduledoc """
  Functions that deal with our lovely Pokemons
  """

  @spec get_name_by_id(id :: String.t()) :: String.t() | {:error, atom}
  def get_name_by_id(id) do
    case impl().get_by_id(id) do
      {:ok, %{"name" => name}} -> name
      error -> error
    end
  end

  @spec get_id_by_name(name :: String.t()) :: integer | {:error, atom}
  def get_id_by_name(name) do
    case impl().get_by_name(name) do
      {:ok, %{"id" => id}} -> id
      error -> error
    end
  end

  defp impl, do: Application.get_env(:pokemon, __MODULE__, Pokemon.PokeApi.Client)
end
