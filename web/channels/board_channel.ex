defmodule Retro.BoardChannel do
  use Retro.Web, :channel

  def join("board:lobby", payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
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
