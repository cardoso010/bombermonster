defmodule Bombermonster.GameStorageTest do
  use ExUnit.Case, async: true

  alias Bombermonster.GameStorage

  setup do
    player = %{"id" => 1234, "x" => 10, "y" => 10, "color" => "red"}

    {:ok, player: player}
  end

  test "add new player", ctx do
    assert :ok = GameStorage.add_player(ctx.player)
  end

  test "get players", ctx do
    GameStorage.add_player(ctx.player)

    assert %{1234 => %{"id" => _, "x" => 10, "y" => 10, "color" => "red"}} =
             GameStorage.get_players()
  end

  test "update player", ctx do
    GameStorage.add_player(ctx.player)

    assert :ok = GameStorage.update_player(%{ctx.player | "x" => 12})

    assert %{1234 => %{"id" => _, "x" => 12, "y" => 10, "color" => "red"}} =
             GameStorage.get_players()
  end
end
