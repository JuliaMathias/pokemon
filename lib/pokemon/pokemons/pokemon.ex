defmodule Pokemon.Pokemons.Pokemon do
  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{}

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  @derive {Jason.Encoder, except: [:__meta__]}

  schema "pokemons" do
    field :name, :string
    field :pokeapi_id, :integer
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
