defmodule Pokemon.PokeApi.Behaviour do
  @moduledoc """
  Behaviour for Pokemon Api Client
  """

  @callback get_by_id(id :: String.t()) ::
              {:ok, %{String.t() => String.t() | integer()}} | {:error, reason :: atom}
  @callback get_by_name(name :: String.t()) ::
              {:ok, %{String.t() => String.t() | integer()}} | {:error, reason :: atom}
end
