defmodule Quest.WebTest do
  use Quest.DataCase

  alias Quest.Web

  describe "profiles" do
    alias Quest.Web.Profile

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def profile_fixture(attrs \\ %{}) do
      {:ok, profile} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Web.create_profile()

      profile
    end

    test "list_profiles/0 returns all profiles" do
      profile = profile_fixture()
      assert Web.list_profiles() == [profile]
    end

    test "get_profile!/1 returns the profile with given id" do
      profile = profile_fixture()
      assert Web.get_profile!(profile.id) == profile
    end

    test "create_profile/1 with valid data creates a profile" do
      assert {:ok, %Profile{} = profile} = Web.create_profile(@valid_attrs)
    end

    test "create_profile/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Web.create_profile(@invalid_attrs)
    end

    test "update_profile/2 with valid data updates the profile" do
      profile = profile_fixture()
      assert {:ok, profile} = Web.update_profile(profile, @update_attrs)
      assert %Profile{} = profile
    end

    test "update_profile/2 with invalid data returns error changeset" do
      profile = profile_fixture()
      assert {:error, %Ecto.Changeset{}} = Web.update_profile(profile, @invalid_attrs)
      assert profile == Web.get_profile!(profile.id)
    end

    test "delete_profile/1 deletes the profile" do
      profile = profile_fixture()
      assert {:ok, %Profile{}} = Web.delete_profile(profile)
      assert_raise Ecto.NoResultsError, fn -> Web.get_profile!(profile.id) end
    end

    test "change_profile/1 returns a profile changeset" do
      profile = profile_fixture()
      assert %Ecto.Changeset{} = Web.change_profile(profile)
    end
  end

  describe "topics" do
    alias Quest.Web.Topic

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def topic_fixture(attrs \\ %{}) do
      {:ok, topic} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Web.create_topic()

      topic
    end

    test "list_topics/0 returns all topics" do
      topic = topic_fixture()
      assert Web.list_topics() == [topic]
    end

    test "get_topic!/1 returns the topic with given id" do
      topic = topic_fixture()
      assert Web.get_topic!(topic.id) == topic
    end

    test "create_topic/1 with valid data creates a topic" do
      assert {:ok, %Topic{} = topic} = Web.create_topic(@valid_attrs)
      assert topic.name == "some name"
    end

    test "create_topic/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Web.create_topic(@invalid_attrs)
    end

    test "update_topic/2 with valid data updates the topic" do
      topic = topic_fixture()
      assert {:ok, topic} = Web.update_topic(topic, @update_attrs)
      assert %Topic{} = topic
      assert topic.name == "some updated name"
    end

    test "update_topic/2 with invalid data returns error changeset" do
      topic = topic_fixture()
      assert {:error, %Ecto.Changeset{}} = Web.update_topic(topic, @invalid_attrs)
      assert topic == Web.get_topic!(topic.id)
    end

    test "delete_topic/1 deletes the topic" do
      topic = topic_fixture()
      assert {:ok, %Topic{}} = Web.delete_topic(topic)
      assert_raise Ecto.NoResultsError, fn -> Web.get_topic!(topic.id) end
    end

    test "change_topic/1 returns a topic changeset" do
      topic = topic_fixture()
      assert %Ecto.Changeset{} = Web.change_topic(topic)
    end
  end
end
