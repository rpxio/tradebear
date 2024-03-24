defmodule TradebearWeb.PropertyManagement.PropertyDetailsLive do
  use TradebearWeb, :live_view
  alias Tradebear.PropertyManagement
  alias Tradebear.PropertyManagement.Property

  def render(assigns) do
    ~H"""
    <h2 class="py-5"><%= @property.address %></h2>

    <h3 class="pt-10">Client</h3>
    <p><%= @property.client.name %></p>
    <p class="text-gray-400"><%= @property.client.billing_address %></p>

    <h3 class="pt-10">Notes</h3>
    <div :for={note <- @property.notes} class="flex flex-col gap-5">
      <p><%= note.data %></p>
    </div>

    <div class="pt-3 flex gap-3">
      <.button type="action" phx-click="add_note" phx-value-property-id={@property.id}>
        Add Note
      </.button>
    </div>
    """
  end

  def mount(%{"id" => property_id}, _session, socket) do
    property =
      Property.get_by_id(property_id)
      |> PropertyManagement.load!([:client, :notes])

    {:ok, assign(socket, property: property)}
  end

  def handle_event("add_note", %{"property-id" => property_id}, socket) do
    {:noreply, redirect(socket, to: ~p"/properties/#{property_id}/add_note")}
  end
end
