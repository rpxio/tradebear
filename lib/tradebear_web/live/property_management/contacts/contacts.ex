defmodule TradebearWeb.PropertyManagement.ContactsLive do
  use TradebearWeb, :live_view
  alias Tradebear.PropertyManagement.Contact

  def render(assigns) do
    ~H"""
    <h2 class="text-3xl">Contacts</h2>
    <div class="flex flex-col gap-2">
      <div :for={contact <- @contacts} class="flex justify-between gap-5 border-b border-zinc-100">
        <div class="flex flex-col gap-1 items-left">
          <p class="text-lg"><%= contact.name %></p>
          <p class="text-md text-gray-400 max-w-60 truncate"><%= contact.email %></p>
        </div>
        <div class="py-2">
          <button class="btn" phx-click="manage_contact" phx-value-contact-id={contact.id}>
            Manage
          </button>
        </div>
      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    contacts = Contact.get_all!()
    {:ok, assign(socket, contacts: contacts)}
  end

  def handle_event("add_note", %{"contact-id" => contact_id}, socket) do
    {:noreply, redirect(socket, to: ~p"/contacts/#{contact_id}/add_note")}
  end

  def handle_event("manage_contact", %{"contact-id" => contact_id}, socket) do
    {:noreply, redirect(socket, to: ~p"/contacts/#{contact_id}")}
  end

  def handle_event("create_contact", _args, socket) do
    {:noreply, redirect(socket, to: ~p"/contacts/new")}
  end
end
