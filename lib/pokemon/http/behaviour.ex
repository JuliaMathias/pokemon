defmodule Pokemon.Http.Behaviour do
  @moduledoc """
  Behaviour for Pokemon Api Client
  """

  @callback get_by_id(id :: String.t()) :: {:ok, map} | {:error, reason :: atom}
  @callback get_by_name(name :: String.t()) :: {:ok, map} | {:error, reason :: atom}
end
