defmodule BombermonsterWeb.PageController do
  use BombermonsterWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
