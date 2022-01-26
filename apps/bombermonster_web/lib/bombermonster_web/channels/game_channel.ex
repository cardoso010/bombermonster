defmodule BombermonsterWeb.GameChannel do
  use BombermonsterWeb, :channel

  alias Bombermonster.GameStorage

  @impl true
  def join("game:lobby", %{"player" => player}, socket) do
    GameStorage.add_player(player)
    {:ok, GameStorage.get_players(), socket}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  @impl true
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (game:lobby).
  @impl true
  def handle_in("shout", payload, socket) do
    broadcast(socket, "shout", payload)
    {:noreply, socket}
  end

  @impl true
  def handle_in("move", player, socket) do
    GameStorage.update_player(player)
    players = GameStorage.get_players()
    broadcast(socket, "update_players", players)
    {:reply, {:ok, players}, socket}
  end
end
