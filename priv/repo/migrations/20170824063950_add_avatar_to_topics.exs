defmodule Quest.Repo.Migrations.AddAvatarToTopics do
  use Ecto.Migration

  def change do
    alter table :topics do
      add :avatar, :string
    end
  end
end
