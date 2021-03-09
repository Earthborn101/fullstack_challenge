defmodule FullstackChallenge.PercentageQualityTest do
  use FullstackChallenge.DataCase

  alias FullstackChallenge.PercentageQuality

  describe "person" do
    alias FullstackChallenge.PercentageQuality.Person

    @valid_attrs %{name: "some name", percentage: 42}
    @update_attrs %{name: "some updated name", percentage: 43}
    @invalid_attrs %{name: nil, percentage: nil}

    def person_fixture(attrs \\ %{}) do
      {:ok, person} =
        attrs
        |> Enum.into(@valid_attrs)
        |> PercentageQuality.create_person()

      person
    end

    test "list_person/0 returns all person" do
      person = person_fixture()
      assert PercentageQuality.list_person() == [person]
    end

    test "get_person!/1 returns the person with given id" do
      person = person_fixture()
      assert PercentageQuality.get_person!(person.id) == person
    end

    test "create_person/1 with valid data creates a person" do
      assert {:ok, %Person{} = person} = PercentageQuality.create_person(@valid_attrs)
      assert person.name == "some name"
      assert person.percentage == 42
    end

    test "create_person/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PercentageQuality.create_person(@invalid_attrs)
    end

    test "update_person/2 with valid data updates the person" do
      person = person_fixture()
      assert {:ok, %Person{} = person} = PercentageQuality.update_person(person, @update_attrs)
      assert person.name == "some updated name"
      assert person.percentage == 43
    end

    test "update_person/2 with invalid data returns error changeset" do
      person = person_fixture()
      assert {:error, %Ecto.Changeset{}} = PercentageQuality.update_person(person, @invalid_attrs)
      assert person == PercentageQuality.get_person!(person.id)
    end

    test "delete_person/1 deletes the person" do
      person = person_fixture()
      assert {:ok, %Person{}} = PercentageQuality.delete_person(person)
      assert_raise Ecto.NoResultsError, fn -> PercentageQuality.get_person!(person.id) end
    end

    test "change_person/1 returns a person changeset" do
      person = person_fixture()
      assert %Ecto.Changeset{} = PercentageQuality.change_person(person)
    end
  end
end
