defmodule QuestWeb.PageController do
  use QuestWeb, :controller
  alias QuestWeb.Helpers.Auth

  def index(conn, _params) do
    current_user = Auth.current_user(conn)
    topics = []
    if current_user, do: topics = Quest.Web.Topic |> Quest.Repo.all |> Enum.chunk_every(4)
    render conn, "index.html", current_user: current_user, topics: topics
  end

  def setup_account(conn, params) do
    current_user = Auth.current_user(conn)
    try do
      {setup_step, _} = Integer.parse(params["step"] || "1")
      if current_user.setup_done do
        redirect conn, to: page_path(conn, :index, %{})
      else
        if setup_step == current_user.setup_step + 1 do
          render conn, "setup_account.html", step: setup_step, current_user: current_user
        else
          redirect conn, to: setup_account_path(
            conn, :setup_account, %{"step" => current_user.setup_step + 1}
          )
        end
      end
    rescue e -> e
      _ = e
      redirect conn, to: setup_account_path(
        conn, :setup_account, %{"step" => current_user.setup_step + 1}
      )
    end
  end
end
