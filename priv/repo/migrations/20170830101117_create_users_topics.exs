defmodule Quest.Repo.Migrations.CreateUsersTopics do
  use Ecto.Migration

  def change do
    create table(:users_topics) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :topic_id, references(:topics, on_delete: :delete_all)
      timestamps()
    end

    create index(:users_topics, [:user_id])
    create index(:users_topics, [:topic_id])
  end
end
