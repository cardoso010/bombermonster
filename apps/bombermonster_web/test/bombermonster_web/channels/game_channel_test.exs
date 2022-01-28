defmodule BombermonsterWeb.GameChannelTest do
  use BombermonsterWeb.ChannelCase

  setup do
    player = %{"id" => 1234, "x" => 10, "y" => 10, "color" => "red"}

    {:ok, _, socket} =
      BombermonsterWeb.GameSocket
      |> socket()
      |> subscribe_and_join(BombermonsterWeb.GameChannel, "game:lobby", %{"player" => player})

    %{socket: socket, player: player}
  end

  test "move broadcasts to game:lobby", %{socket: socket, player: player} do
    push(socket, "move", player)
    assert_broadcast "update_players", %{1234 => ^player}
  end
end
