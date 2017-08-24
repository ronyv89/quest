defmodule QuestWeb.PageController do
  use QuestWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
