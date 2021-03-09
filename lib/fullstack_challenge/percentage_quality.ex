defmodule FullstackChallenge.PercentageQuality do
  @moduledoc """
  The PercentageQuality context.
  """

  import Ecto.Query, warn: false
  alias FullstackChallenge.Repo
  alias FullstackChallenge.PercentageQuality.Person

  def validate_params(params \\ %{}) do
    %Person{}
    |> Person.validate_changeset(params)
  end

  def insert_person(params \\ %{}) do
    params = add_name_group(params)

    %Person{}
    |> Person.changeset(params)
    |> Repo.insert()
  end

  def get_persons do
    Repo.all(Person)
  end

  defp add_name_group(%{"name" => name} = params) do
    name
    |> String.first()
    |> String.upcase()
    |> set_name_group(params)
  end
  defp add_name_group(params), do: params

  defp set_name_group(letter, params)
  when letter in ["A", "B", "C", "D", "E", "F", "G", "H", "I"] do
    params
    |> Map.put("name_group", "AI")
  end
  defp set_name_group(letter, params)
  when letter in ["J", "K", "L", "M", "N", "O", "P", "Q", "R"] do
    params
    |> Map.put("name_group", "JR")
  end
  defp set_name_group(letter, params)
  when letter in ["S", "T", "U", "V", "W", "X", "Y", "Z"] do
    params
    |> Map.put("name_group", "SZ")
  end
end
