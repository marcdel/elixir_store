defmodule ElixirStore.Web.PageController do
  use ElixirStore.Web.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
