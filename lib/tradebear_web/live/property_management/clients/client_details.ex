defmodule TradebearWeb.PropertyManagement.ClientDetailsLive do
  use TradebearWeb, :live_view
  alias Tradebear.PropertyManagement
  alias Tradebear.PropertyManagement.Client

  def render(assigns) do
    ~H"""
    <h2 class="py-5"><%= @client.name %></h2>
    <p>Billing address: <%= @client.billing_address %></p>

    <h3 class="pt-10">Contacts</h3>
    <div :for={contact <- @client.contacts} class="flex flex-col gap-5">
      <div>
        <div class="flex row gap-10 pb-2">
          <%= contact.name %>
          <%= contact.phone %>
          <%= contact.email %>
          <%= contact.address %>
        </div>
        <div>
          <div :for={note <- contact.notes} :if={contact.notes} class="flex gap-2">
            <p class="bg-gray-200"><%= note.data %></p>
          </div>
        </div>
      </div>
    </div>

    <h3 class="pt-10">Notes</h3>
    <div :for={note <- @client.notes} class="flex flex-col gap-5">
      <p><%= note.data %></p>
    </div>

    <h3 class="pt-10">Properties</h3>
    <div :for={property <- @client.properties} class="flex flex-col gap-5">
      <p><%= property.address %></p>
    </div>

    <div class="pt-3 flex gap-3">
      <button class="btn" phx-click="add_contact" phx-value-client-id={@client.id}>
        Add Contact
      </button>
      <button class="btn" phx-click="add_note" phx-value-client-id={@client.id}>
        Add Note
      </button>
      <button class="btn" phx-click="add_property" phx-value-client-id={@client.id}>
        Add Property
      </button>
    </div>
    """
  end

  def mount(%{"id" => client_id}, _session, socket) do
    client =
      Client.get_by_id(client_id)
      |> PropertyManagement.load!([:notes, contacts: [:notes], properties: [:notes]])

    {:ok, assign(socket, client: client)}
  end

  def handle_event("add_contact", %{"client-id" => client_id}, socket) do
    {:noreply, redirect(socket, to: ~p"/clients/#{client_id}/add_contact")}
  end

  def handle_event("add_property", %{"client-id" => client_id}, socket) do
    {:noreply, redirect(socket, to: ~p"/clients/#{client_id}/add_property")}
  end

  def handle_event("add_note", %{"client-id" => client_id}, socket) do
    {:noreply, redirect(socket, to: ~p"/clients/#{client_id}/add_note")}
  end
end
