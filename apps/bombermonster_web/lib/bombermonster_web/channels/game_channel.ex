defmodule BombermonsterWeb.GameChannel do
  @moduledoc """
  GameChannel Module
  """
  use BombermonsterWeb, :channel

  alias Bombermonster.GameStorage

  @impl true
  def join("game:lobby", %{"player" => player}, socket) do
    GameStorage.add_player(player)
    {:ok, GameStorage.get_players(), socket}
  end

  @impl true
  def handle_in("move", player, socket) do
    GameStorage.update_player(player)
    refresh_players(socket)
    {:noreply, socket}
  end

  defp refresh_players(socket) do
    players = GameStorage.get_players()
    broadcast(socket, "update_players", players)
  end
end
