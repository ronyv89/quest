require IEx
defmodule QuestWeb.ProfileController do
  use QuestWeb, :controller

  alias Quest.Web
  alias Quest.Web.Profile
  alias Quest.Repo
  def index(conn, _params) do
    profiles = Web.list_profiles()
    render(conn, "index.html", profiles: profiles)
  end

  def new(conn, _params) do
    changeset = Web.change_profile(%Profile{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"profile" => profile_params}) do
    case Web.create_profile(profile_params) do
      {:ok, profile} ->
        conn
        |> put_flash(:info, "Profile created successfully.")
        |> redirect(to: profile_path(conn, :show, profile))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, _params) do
    user = Coherence.current_user(conn) |> Repo.preload(:profile)
    profile = user.profile
    # # profile = Web.get_profile!(id)
    render(conn, "show.html", profile: profile, user: user)
  end

  def edit(conn, %{"id" => id}) do
    profile = Web.get_profile!(id)
    changeset = Web.change_profile(profile)
    render(conn, "edit.html", profile: profile, changeset: changeset)
  end

  def update(conn, %{"id" => id, "profile" => profile_params}) do
    profile = Web.get_profile!(id)

    case Web.update_profile(profile, profile_params) do
      {:ok, profile} ->
        conn
        |> put_flash(:info, "Profile updated successfully.")
        |> redirect(to: profile_path(conn, :show, profile))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", profile: profile, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    profile = Web.get_profile!(id)
    {:ok, _profile} = Web.delete_profile(profile)

    conn
    |> put_flash(:info, "Profile deleted successfully.")
    |> redirect(to: profile_path(conn, :index))
  end
end
