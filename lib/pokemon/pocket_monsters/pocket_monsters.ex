defmodule Pokemon.PocketMonsters do
  @moduledoc """
  This is the PocketMonsters context. It is used to house functions that both ping the Poke API and interact with the Repo.
  """

  import Ecto.Query

  alias Pokemon.PocketMonsters.PocketMonster
  alias Pokemon.Repo

  @doc """
  This function returns a name when given the pokemon's id in the Poke API. If the pokemon is already cached in the database, no request is made.
  """
  @spec get_name_by_id(id :: String.t()) ::
          String.t() | {:error, atom | Ecto.Changeset.t()}
  def get_name_by_id(id) do
    with nil <- Repo.one(from p in PocketMonster, where: p.pokeapi_id == ^id),
         {:ok, pokemon} <- impl().get_by_id(id),
         {:ok, %PocketMonster{name: name}} <- save_pokemon(pokemon) do
      name
    else
      %PocketMonster{name: name} -> name
      error -> error
    end
  end

  @doc """
  This function returns the pokemon's id in the Poke API when given a name. If the pokemon is already cached in the database, no request is made.
  """
  @spec get_id_by_name(name :: String.t()) ::
          String.t() | {:error, atom | Ecto.Changeset.t()}
  def get_id_by_name(name) do
    with nil <- Repo.one(from p in PocketMonster, where: p.name == ^name),
         {:ok, pokemon} <- impl().get_by_name(name),
         {:ok, %PocketMonster{pokeapi_id: pokeapi_id}} <- save_pokemon(pokemon) do
      pokeapi_id
    else
      %PocketMonster{pokeapi_id: id} -> id
      error -> error
    end
  end

  defp save_pokemon(%{"name" => name, "id" => id} = pokemon) do
    PocketMonster.changeset(%PocketMonster{}, %{
      pokeapi_id: Integer.to_string(id),
      name: name,
      response: pokemon
    })
    |> Repo.insert()
  end

  defp impl, do: Application.get_env(:pokemon, __MODULE__, Pokemon.PokeApi.Client)
end
