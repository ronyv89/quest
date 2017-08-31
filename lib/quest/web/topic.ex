defmodule Quest.Web.Topic do
  use Ecto.Schema
  import Ecto.Changeset
  alias Quest.Web.Topic
  use Arc.Ecto.Schema

  schema "topics" do
    field :name, :string
    field :avatar, Quest.Avatar.Type
    many_to_many :users, Quest.Coherence.User, join_through: "users_topics"
    timestamps()
  end

  @doc false
  def changeset(%Topic{} = topic, attrs) do
    topic
    |> cast(attrs, [:name])
    |> cast_attachments(attrs, [:avatar])
    |> validate_required([:name])
  end
end
