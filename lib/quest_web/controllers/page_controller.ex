defmodule QuestWeb.PageController do
  use QuestWeb, :controller
  import Ecto.Query
  alias QuestWeb.Helpers.Auth
  alias Quest.Coherence.User

  def index(conn, _params) do
    current_user = Auth.current_user(conn, true, [user_topics: :topic])
    if current_user do
      if current_user.setup_step == 0 do
        topics = Quest.Web.Topic |> Quest.Repo.all |> Enum.chunk_every(3)
        changeset = case current_user.setup_step do
          0 -> User.changeset(current_user, %{})
          1 -> User.changeset(current_user, %{})
        end
        render conn, "index.html", current_user: current_user, topics: topics, changeset: changeset
      else
        topics = current_user.user_topics
        render conn, "index.html", current_user: current_user, topics: topics
      end
    else
      render conn, "index.html", current_user: current_user, conn: conn
    end
  end

  def setup_account(conn, params) do
    current_user = Auth.current_user(conn, true, [user_topics: :topic])
    topics = Quest.Web.Topic |> Quest.Repo.all |> Enum.chunk_every(3)
    if params["user"] do
      user_params = Map.merge(params["user"] || %{}, %{ "setup_step" => current_user.setup_step + 1, "setup_done" => true })
      changeset = current_user |> User.changeset(user_params)
      case Quest.Repo.update(changeset) do
        {:ok, user} ->
          conn
          |> put_flash(:info, "Topics updated")
          |> redirect(to: page_path(conn, :index))
        {:error, %Ecto.Changeset{} = changeset} ->
          render conn, "index.html", current_user: current_user, conn: conn, changeset: changeset, topics: topics
      end
    else
      changeset = current_user |> User.changeset(%{})
      conn
        |> put_flash(:error, "Select atleast 1 topic")
        |> render "index.html", current_user: current_user, conn: conn, changeset: changeset, topics: topics
    end
  end
end
