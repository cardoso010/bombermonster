defmodule Bombermonster.GameStorageTest do
  use ExUnit.Case, async: true

  alias Bombermonster.GameStorage

  setup do
    player = %{id: "1234", x: 10, y: 10, color: "red"}

    {:ok, player: player}
  end

  test "add new player", ctx do
    assert :ok = GameStorage.add_player(ctx.player)
  end

  test "get players", ctx do
    GameStorage.add_player(ctx.player)
    assert {:ok, players} = GameStorage.get_players()
    assert %{"1234": %{id: _, x: _, y: _, color: _}} = players
  end
end
