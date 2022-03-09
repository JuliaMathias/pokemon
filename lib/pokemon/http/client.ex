defmodule Pokemon.Http.Client do
  @moduledoc """
  Client for the Pokemon API.
  """

  use Tesla, only: [:get]

  plug Tesla.Middleware.BaseUrl, "https://pokeapi.co/api/v2/pokemon/"
  plug Tesla.Middleware.JSON

  @behaviour Pokemon.Http.Behaviour

  # Here I wondered if I shouldn't just do one generalist function that requested by both name or ID
  # but I feel like doing it this way would be less confusing.

  @doc """
  Makes a request to the Pokemon API using an id and returns either an error tuple, or a tuple with :ok and a map with information about the pokemon.
  """
  @impl true
  def get_by_id(id) do
    case get(id) do
      {:ok, %Tesla.Env{body: body, status: 200}} -> {:ok, body}
      error -> handle_error(error)
    end
  end

  @doc """
  Makes a request to the Pokemon API using a name and returns either an error tuple, or a tuple with :ok and a map with information about the pokemon.
  """
  @impl true
  def get_by_name(name) do
    case get(name) do
      {:ok, %Tesla.Env{body: body, status: 200}} -> {:ok, body}
      error -> handle_error(error)
    end
  end

  defp handle_error({:ok, %Tesla.Env{status: 404}}), do: {:error, :not_found}
  defp handle_error(_), do: {:error, :unexpected}
end
