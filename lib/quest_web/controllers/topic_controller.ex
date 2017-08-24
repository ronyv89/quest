defmodule QuestWeb.TopicController do
  use QuestWeb, :controller

  alias Quest.Web
  alias Quest.Web.Topic

  def index(conn, _params) do
    topics = Web.list_topics()
    render(conn, "index.html", topics: topics)
  end

  def new(conn, _params) do
    changeset = Web.change_topic(%Topic{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"topic" => topic_params}) do
    case Web.create_topic(topic_params) do
      {:ok, topic} ->
        conn
        |> put_flash(:info, "Topic created successfully.")
        |> redirect(to: topic_path(conn, :show, topic))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    topic = Web.get_topic!(id)
    render(conn, "show.html", topic: topic)
  end

  def edit(conn, %{"id" => id}) do
    topic = Web.get_topic!(id)
    changeset = Web.change_topic(topic)
    render(conn, "edit.html", topic: topic, changeset: changeset)
  end

  def update(conn, %{"id" => id, "topic" => topic_params}) do
    topic = Web.get_topic!(id)

    case Web.update_topic(topic, topic_params) do
      {:ok, topic} ->
        conn
        |> put_flash(:info, "Topic updated successfully.")
        |> redirect(to: topic_path(conn, :show, topic))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", topic: topic, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    topic = Web.get_topic!(id)
    {:ok, _topic} = Web.delete_topic(topic)

    conn
    |> put_flash(:info, "Topic deleted successfully.")
    |> redirect(to: topic_path(conn, :index))
  end
end
