defmodule QuestWeb.Plug.Admin do
  @behaviour Plug
  import Plug.Conn
  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]

  def init(opts), do: opts

  def call(conn, _opts) do
    if Coherence.current_user(conn).role == "admin" do
      conn
    else
      conn
      |> put_flash(:error, "You must be an admin to access that page.")
      |> redirect(to: QuestWeb.Router.Helpers.page_path(conn, :index))
      |> halt()
    end
  end
end