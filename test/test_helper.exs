ExUnit.start()

# Configure Mox
Mox.defmock(BehaviourMock, for: Pokemon.Http.Behaviour)
Application.put_env(:pokemon, Pokemon.Pokemons.PokemonRepository, BehaviourMock)

Ecto.Adapters.SQL.Sandbox.mode(Pokemon.Repo, :manual)
