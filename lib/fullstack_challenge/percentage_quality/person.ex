defmodule FullstackChallenge.PercentageQuality.Person do
  use Ecto.Schema
  import Ecto.Changeset

  alias FullstackChallenge.PercentageQuality

  schema "person" do
    field :name, :string
    field :percentage, :integer
    field :name_group, :string

    timestamps()
  end

  @doc false
  def changeset(person, attrs) do
    person
    |> cast(attrs, [:name, :percentage, :name_group])
    |> validate_required([:name, :percentage, ])
    |> validate_inclusion(
      :name_group,
      ["AI", "JR", "SZ"],
      message: "Invalid name group"
    )
    |> validate_params()
    |> validate_name_if_exist()
  end

  def validate_changeset(person, attrs) do
    person
    |> cast(attrs, [:name, :percentage])
    |> validate_params()
  end

  defp validate_params(changeset) do
    changeset
    |> validate_length(:name, max: 80, message: "Must not exceed 80 characters")
    |> validate_number(
      :percentage,
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 100
    )
  end

  defp validate_name_if_exist(%{changes: %{name: name}} = changeset) do
    name
    |> PercentageQuality.validate_person()
    |> validate_name_if_exist(changeset)
  end
  defp validate_name_if_exist(changeset), do: changeset

  defp validate_name_if_exist([], changeset), do: changeset
  defp validate_name_if_exist(_, changeset) do
    changeset
    |> add_error(:name, "Already exist")
  end
end
