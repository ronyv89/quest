defmodule Quest.QuestTest do
  use Quest.DataCase

  alias Quest.Quest

  describe "profiles" do
    alias Quest.Quest.Profile

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def profile_fixture(attrs \\ %{}) do
      {:ok, profile} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Quest.create_profile()

      profile
    end

    test "list_profiles/0 returns all profiles" do
      profile = profile_fixture()
      assert Quest.list_profiles() == [profile]
    end

    test "get_profile!/1 returns the profile with given id" do
      profile = profile_fixture()
      assert Quest.get_profile!(profile.id) == profile
    end

    test "create_profile/1 with valid data creates a profile" do
      assert {:ok, %Profile{} = profile} = Quest.create_profile(@valid_attrs)
    end

    test "create_profile/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Quest.create_profile(@invalid_attrs)
    end

    test "update_profile/2 with valid data updates the profile" do
      profile = profile_fixture()
      assert {:ok, profile} = Quest.update_profile(profile, @update_attrs)
      assert %Profile{} = profile
    end

    test "update_profile/2 with invalid data returns error changeset" do
      profile = profile_fixture()
      assert {:error, %Ecto.Changeset{}} = Quest.update_profile(profile, @invalid_attrs)
      assert profile == Quest.get_profile!(profile.id)
    end

    test "delete_profile/1 deletes the profile" do
      profile = profile_fixture()
      assert {:ok, %Profile{}} = Quest.delete_profile(profile)
      assert_raise Ecto.NoResultsError, fn -> Quest.get_profile!(profile.id) end
    end

    test "change_profile/1 returns a profile changeset" do
      profile = profile_fixture()
      assert %Ecto.Changeset{} = Quest.change_profile(profile)
    end
  end

  describe "topics" do
    alias Quest.Quest.Topic

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def topic_fixture(attrs \\ %{}) do
      {:ok, topic} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Quest.create_topic()

      topic
    end

    test "list_topics/0 returns all topics" do
      topic = topic_fixture()
      assert Quest.list_topics() == [topic]
    end

    test "get_topic!/1 returns the topic with given id" do
      topic = topic_fixture()
      assert Quest.get_topic!(topic.id) == topic
    end

    test "create_topic/1 with valid data creates a topic" do
      assert {:ok, %Topic{} = topic} = Quest.create_topic(@valid_attrs)
      assert topic.name == "some name"
    end

    test "create_topic/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Quest.create_topic(@invalid_attrs)
    end

    test "update_topic/2 with valid data updates the topic" do
      topic = topic_fixture()
      assert {:ok, topic} = Quest.update_topic(topic, @update_attrs)
      assert %Topic{} = topic
      assert topic.name == "some updated name"
    end

    test "update_topic/2 with invalid data returns error changeset" do
      topic = topic_fixture()
      assert {:error, %Ecto.Changeset{}} = Quest.update_topic(topic, @invalid_attrs)
      assert topic == Quest.get_topic!(topic.id)
    end

    test "delete_topic/1 deletes the topic" do
      topic = topic_fixture()
      assert {:ok, %Topic{}} = Quest.delete_topic(topic)
      assert_raise Ecto.NoResultsError, fn -> Quest.get_topic!(topic.id) end
    end

    test "change_topic/1 returns a topic changeset" do
      topic = topic_fixture()
      assert %Ecto.Changeset{} = Quest.change_topic(topic)
    end
  end
end
