defmodule Quest.Web.Profile do
  use Ecto.Schema
  import Ecto.Changeset
  alias Quest.Web.Profile


  schema "profiles" do
    # field :user_id, :id
    belongs_to :user, Quest.User
    timestamps()
  end

  @doc false
  def changeset(%Profile{} = profile, attrs) do
    profile
    |> cast(attrs, [])
    |> validate_required([])
  end
end
