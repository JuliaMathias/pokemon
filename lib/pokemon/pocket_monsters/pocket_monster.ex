defmodule Pokemon.PocketMonsters.PocketMonster do
  @moduledoc """
  This module defines the schema for PocketMonsters.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "pocket_monsters" do
    field :name, :string
    field :pokeapi_id, :string
    field :response, :map

    timestamps()
  end

  @doc false
  def changeset(pokemon, attrs) do
    pokemon
    |> cast(attrs, [:name, :pokeapi_id, :response])
    |> validate_required([:name, :pokeapi_id, :response])
  end
end
