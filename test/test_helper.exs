ExUnit.start()

# Configure Mox
Mox.defmock(PokeApiBehaviourMock, for: Pokemon.PokeApi.Behaviour)
Application.put_env(:pokemon, Pokemon.Pokemons.Pokemons, PokeApiBehaviourMock)

Ecto.Adapters.SQL.Sandbox.mode(Pokemon.Repo, :manual)
