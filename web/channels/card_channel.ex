defmodule Retro.CardChannel do
  use Retro.Web, :channel

  def join("card:" <> _card_id, payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end


  def handle_in("card:update", payload, socket) do
    # TODO: implement
  end

  def handle_in("card:delete", payload, socket) do
    # TODO: implement
  end


  def handle_out("card:updated", payload, socket) do
    push socket, "card:updated", payload
    {:noreply, socket}
  end

  def handle_out("card:deleted", payload, socket) do
    push socket, "card:deleted", payload
    {:noreply, socket}
  end


  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
