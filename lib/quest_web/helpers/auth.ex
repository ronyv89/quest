defmodule QuestWeb.Helpers.Auth do
  def current_user(conn, reload \\ true) do
    if Coherence.current_user(conn) && reload do
      Quest.Repo.get!(Quest.Coherence.User, Coherence.current_user(conn).id)
    else
      Coherence.current_user(conn)
    end
  end
end