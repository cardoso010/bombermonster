defmodule Bombermonster.GameStorage do
  @moduledoc false
  use Agent

  def start_link(values \\ %{}) do
    Agent.start_link(fn -> values end, name: __MODULE__)
  end

  def add_player(player) do
    Agent.update(
      __MODULE__,
      &Map.put(&1, player["id"], player)
    )
  end

  def update_player(player) do
    Agent.update(
      __MODULE__,
      &Map.replace(&1, player["id"], player)
    )
  end

  def get_players, do: Agent.get(__MODULE__, fn state -> state end)
end
