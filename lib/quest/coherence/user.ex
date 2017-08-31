require IEx
defmodule Quest.Coherence.User do
  @moduledoc false
  use Ecto.Schema
  use Coherence.Schema
  alias Quest.Web.Profile

  schema "users" do
    field :name, :string
    field :email, :string
    field :setup_done, :boolean
    field :setup_step, :integer
    field :role, :string
    # has_one :profile, Profile
    has_many :user_topics, Quest.Web.UserTopic, on_replace: :delete
    has_many :topics, through: [:user_topics, :user]
    # many_to_many :topics, Quest.Web.Topic, join_through: "users_topics", on_delete: :delete_all
    coherence_schema()

    timestamps()
  end

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, [:name, :email, :setup_step, :setup_done] ++ coherence_fields())
    |> cast_assoc(:user_topics, with: &Quest.Web.UserTopic.changeset(&1, &2, model.id))
    |> validate_required([:name, :email])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> validate_coherence(params)
  end

  def changeset(model, params, :password) do
    model
    |> cast(params, ~w(password password_confirmation reset_password_token reset_password_sent_at))
    |> validate_coherence_password_reset(params)
  end

  def has_topic(model, topic_id) do
    Enum.find(model.user_topics, fn topic -> topic.topic_id == topic_id end)
  end
end
