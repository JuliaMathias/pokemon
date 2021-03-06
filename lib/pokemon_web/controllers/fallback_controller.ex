defmodule PokemonWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use PokemonWeb, :controller

  # This clause is an example of how to handle resources that cannot be found.
  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(PokemonWeb.ErrorView)
    |> render(:"404")
  end

  def call(conn, {:error, :unexpected}) do
    conn
    |> put_status(:internal_server_error)
    |> put_view(PokemonWeb.ErrorView)
    |> render(:"500")
  end
end
