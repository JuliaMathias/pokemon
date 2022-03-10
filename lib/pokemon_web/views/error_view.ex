defmodule PokemonWeb.ErrorView do
  use PokemonWeb, :view

  def render("500.html", _assigns), do: "Internal Server Error"

  def template_not_found(template, _assigns) do
    Phoenix.Controller.status_message_from_template(template)
  end
end
