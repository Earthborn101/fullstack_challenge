defmodule FullstackChallengeWeb.PersonLive.Index do
  use FullstackChallengeWeb, :live_view

  alias FullstackChallenge.PercentageQuality

  @impl true
  def mount(_params, _session, socket) do
    {:ok, fetch(socket)}
  end

  defp fetch(socket) do
    changeset = PercentageQuality.validate_params(%{})
    list_of_persons = PercentageQuality.get_persons()

    socket
    |> assign(:page_title, "Person Quality")
    |> assign(:changeset, changeset)
    |> assign(:list_of_person, list_of_persons)
  end

  @impl true
  def handle_event("validate", %{"person" => person_params}, socket) do
    changeset =
      person_params
      |> PercentageQuality.validate_params()
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  @impl true
  def handle_event("save", %{"person" => person_params}, socket) do
    case PercentageQuality.insert_person(person_params) do
      {:ok, _result} ->
        socket =
          socket
          |> put_flash(:info, "Person created successfully")
          |> push_redirect(to: "/")

        {:noreply, fetch(socket)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end
end
