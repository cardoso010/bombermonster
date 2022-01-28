defmodule BombermonsterWeb.PageControllerTest do
  use BombermonsterWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "<canvas"
  end
end
