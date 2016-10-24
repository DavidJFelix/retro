defmodule Retro.CardView do
  use Retro.Web, :view

  # Explicitly declare the exposed JSON fields to prevent implicit vulns
  def render("card.json", %{card: card}) do
    %{
      id: card.id,
      title: card.title
    }
  end

  def render("index.json", %{cards: cards}) do
    render_many(cards, Retro.CardView, "card.json")
  end

  def render("show.json", %{card: card}) do
    render(Retro.CardView, "card.json", card: card)
  end
end
