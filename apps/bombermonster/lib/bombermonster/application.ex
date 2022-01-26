defmodule Bombermonster.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  alias Bombermonster.GameStorage

  @impl true
  def start(_type, _args) do
    children = [
      # Start the PubSub system
      {Phoenix.PubSub, name: Bombermonster.PubSub},
      # Start a worker by calling: Bombermonster.Worker.start_link(arg)
      # {Bombermonster.Worker, arg}
      {GameStorage, %{}}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Bombermonster.Supervisor)
  end
end
