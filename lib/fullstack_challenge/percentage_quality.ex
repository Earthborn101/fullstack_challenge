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
    |> broadcast(:created)
  end

  def subscribe do
    Phoenix.PubSub.subscribe(FullstackChallenge.PubSub, "post")
  end

  defp broadcast({:error, _reason} = error, _event), do: error
  defp broadcast({:ok, post}, event) do
    Phoenix.PubSub.broadcast(FullstackChallenge.PubSub, "post", {event, post})
    {:ok, post}
  end

  def get_persons do
    Person
    |> order_by([p], asc: p.name)
    |> Repo.all()
  end

  def get_percentage_amount(list) do
    %{}
    |> get_name_group("AI", list)
    |> get_name_group("JR", list)
    |> get_name_group("SZ", list)
  end

  defp get_name_group(map, name_group, list) do
    list =
      list
      |> Enum.filter(&(&1.name_group == name_group))

    if Enum.empty?(list) do
      map
    else
      list_sum =
        list
        |> Enum.map(&(&1.percentage))
        |> Enum.sum()

      map
      |> Map.put(name_group, list_sum)
    end
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

  def validate_person(name) do
    Person
    |> where([p], fragment("lower(?)", p.name) == fragment("lower(?)", ^name))
    |> Repo.all()
  end
end
