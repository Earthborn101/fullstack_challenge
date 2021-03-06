defmodule FullstackChallengeWeb.PersonLive.FormComponent do
  use FullstackChallengeWeb, :live_component

  alias FullstackChallenge.PercentageQuality

  @impl true
  def update(%{person: person} = assigns, socket) do
    changeset = PercentageQuality.change_person(person)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", person_params, socket) do
    changeset =
      socket.assigns.person
      |> PercentageQuality.change_person(person_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("add", person_params, socket) do
    raise 1
  end

  defp save_person(socket, :edit, person_params) do
    case PercentageQuality.update_person(socket.assigns.person, person_params) do
      {:ok, _person} ->
        {:noreply,
         socket
         |> put_flash(:info, "Person updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_person(socket, :new, person_params) do
    case PercentageQuality.create_person(person_params) do
      {:ok, _person} ->
        {:noreply,
         socket
         |> put_flash(:info, "Person created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
