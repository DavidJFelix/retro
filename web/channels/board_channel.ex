defmodule Retro.BoardChannel do
  use Retro.Web, :channel

  alias Retro.{Card, Endpoint, ErrorView}

  def join("board:lobby", payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def join("board:" <> _card_id, payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_in("card:create", payload, socket) do
    changeset = Card.changeset(%Card{}, payload)

    case Repo.insert(changeset) do
      {:ok, card} ->
        Endpoint.broadcast("board:lobby", "card:created", card)
        {:ok, socket}
      {:error, changeset} ->
        {:error, %{}}
    end
  end

  def handle_out("card:created", payload, socket) do
    push socket, "card:created", payload
    {:noreply, socket}
  end


  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
