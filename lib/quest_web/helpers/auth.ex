defmodule QuestWeb.Helpers.Auth do
  import Ecto.Query
  alias Quest.Repo
  def current_user(conn, reload \\ true, preload \\ []) do
    current_user = Coherence.current_user(conn)
    if current_user && reload do
      Repo.one from u in Quest.Coherence.User, where: u.id == ^current_user.id, preload: ^preload
    else
      Coherence.current_user(conn)
    end
  end
end