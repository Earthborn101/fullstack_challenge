defmodule FullstackChallengeWeb.PersonLiveTest do
  use FullstackChallengeWeb.ConnCase

  import Phoenix.LiveViewTest

  alias FullstackChallenge.PercentageQuality

  @create_attrs [%{name: "Ryan Adiao", percentage: 42}, %{name: "John Doe", percentage: 23}]
  @invalid_attrs %{name: nil, percentage: nil}

  defp create_person do
    person =
      @create_attrs
      |> Enum.map(&(PercentageQuality.insert_person(&1)))

    %{person: person}
  end

  describe "Index_test" do
    test "lists all person", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, Routes.person_index_path(conn, :index))
      assert html =~ "Person Quality"
    end

    test "saves new person", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.person_index_path(conn, :index))

      {:ok, html} =
        index_live
        |> form("#person-form", person: %{"name"=> "New Name", "percentage"=> "45"})
        |> render_submit()
        |> follow_redirect(conn, Routes.person_index_path(conn, :index))

      assert html.resp_body =~ "New Name"
      assert html.resp_body =~ "45"
    end
  end
end
