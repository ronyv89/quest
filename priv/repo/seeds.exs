# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Quest.Repo.insert!(%Quest.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

Quest.Repo.delete_all Quest.Coherence.User

Quest.Coherence.User.changeset(%Quest.Coherence.User{}, %{name: "Test User", email: "testuser@example.com", password: "secret", password_confirmation: "secret"})
  |> Quest.Repo.insert!
  |> Coherence.Controller.confirm!
  