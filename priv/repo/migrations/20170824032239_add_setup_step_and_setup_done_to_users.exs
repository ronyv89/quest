defmodule Quest.Repo.Migrations.AddSetupStepAndSetupDoneToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :setup_step, :integer, default: 0
      add :setup_done, :boolean, default: false
    end
  end
end
