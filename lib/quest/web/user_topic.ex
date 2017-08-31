defmodule Quest.Web.UserTopic do
  use Ecto.Schema
  import Ecto.Changeset
  alias Quest.Web.UserTopic


  schema "users_topics" do
    belongs_to :user, Quest.Coherence.User
    belongs_to :topic, Quest.Web.Topic
    field :delete, :boolean, virtual: true, default: false
    timestamps()
  end

  @doc false
  def changeset(%UserTopic{} = user_topic, attrs) do
    user_topic
    |> cast(attrs, [])
    |> validate_required([])
    |> mark_for_deletion()
  end

  def changeset(%UserTopic{} = user_topic, attrs, user_id) do
    attrs = Map.put(attrs, "user_id", user_id)
    user_topic
    |> cast(attrs, [:user_id, :topic_id, :delete])
    |> validate_required([])
    |> mark_for_deletion()
  end

  defp mark_for_deletion(changeset) do
    if get_change(changeset, :delete) do
      %{changeset | action: :delete}
    else
      changeset
    end
  end
end
