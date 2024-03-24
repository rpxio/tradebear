defmodule TradebearWeb.PropertyManagement.AddContactNoteLive do
  use TradebearWeb, :live_view

  alias Tradebear.PropertyManagement

  def render(assigns) do
    ~H"""
    <h2 class="text-2xl">Create Note for <%= @contact.name %></h2>
    <.form for={@form} phx-change="validate_note" phx-submit="create_note">
      <.input field={@form[:data]} type="text" label="Note" autofocus />
      <.button type="submit" class="float-right">Create</.button>
    </.form>
    """
  end

  def mount(%{"id" => contact_id}, _session, socket) do
    contact = PropertyManagement.Contact.get_by_id!(contact_id)

    form =
      AshPhoenix.Form.for_create(PropertyManagement.Note, :create, api: PropertyManagement)
      |> to_form()

    {:ok, assign(socket, contact: contact, form: form)}
  end

  def handle_event("validate_note", %{"form" => note_params}, socket) do
    form = AshPhoenix.Form.validate(socket.assigns.form, note_params)
    {:noreply, assign(socket, form: form)}
  end

  def handle_event("create_note", %{"form" => note_params}, socket) do
    note_params = Map.put(note_params, :contact_id, socket.assigns.contact.id)

    case AshPhoenix.Form.submit(socket.assigns.form, params: note_params) do
      {:ok, _note} ->
        {:noreply, redirect(socket, to: ~p"/contacts/#{socket.assigns.contact.id}")}

      {:error, form} ->
        {:noreply, assign(socket, form: form)}
    end
  end
end
