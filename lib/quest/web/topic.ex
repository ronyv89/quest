defmodule Quest.Web.Topic do
  use Ecto.Schema
  import Ecto.Changeset
  alias Quest.Web.Topic


  schema "topics" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%Topic{} = topic, attrs) do
    topic
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
