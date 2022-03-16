ExUnit.start()

# Configure Hammox
Hammox.defmock(PokeApiBehaviourMock, for: Pokemon.PokeApi.Behaviour)
Application.put_env(:pokemon, Pokemon.PocketMonsters, PokeApiBehaviourMock)

Ecto.Adapters.SQL.Sandbox.mode(Pokemon.Repo, :manual)
