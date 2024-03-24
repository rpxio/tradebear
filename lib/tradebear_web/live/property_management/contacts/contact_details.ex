defmodule TradebearWeb.PropertyManagement.ContactDetailsLive do
  use TradebearWeb, :live_view

  alias Tradebear.PropertyManagement

  def render(assigns) do
    ~H"""
    <div class="pb-3">
      <h2 class="text-2xl"><%= @contact.name %></h2>
      <p><%= @contact.email %></p>
      <p><%= @contact.phone %></p>
      <p><%= @contact.address %></p>
    </div>
    <div class="pb-3">
      <h3 class="text-xl">Clients</h3>
      <div :for={client <- @contact.clients} class="flex flex-col gap-2 py-2">
        <p><%= client.name %></p>
        <p class="text-gray-400 text-sm"><%= client.billing_address %></p>
      </div>
    </div>
    <div>
      <h3 class="text-xl">Notes</h3>
      <div :for={note <- @contact.notes} class="flex flex-col gap-2 py-2">
        <p><%= note.data %></p>
      </div>
    </div>
    <div class="pt-3 flex gap-3">
      <.button type="action" phx-click="add_note" phx-value-contact-id={@contact.id}>
        Add Note
      </.button>
    </div>
    """
  end

  def mount(%{"id" => contact_id}, _session, socket) do
    contact =
      PropertyManagement.Contact.get_by_id!(contact_id)
      |> PropertyManagement.load!([:clients, :notes])

    {:ok, assign(socket, contact: contact)}
  end

  def handle_event("add_note", %{"contact-id" => contact_id}, socket) do
    {:noreply, redirect(socket, to: ~p"/contacts/#{contact_id}/add_note")}
  end
end
