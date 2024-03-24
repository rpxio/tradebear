defmodule TradebearWeb.PropertyManagement.PropertiesLive do
  use TradebearWeb, :live_view
  alias Tradebear.PropertyManagement.Property

  def render(assigns) do
    ~H"""
    <h2 class="text-3xl border-b border-zinc-100">Properties</h2>
    <div
      :for={property <- @properties}
      class="flex flex-row justify-between gap-5 border-b border-zinc-100"
    >
      <div>
        <p class="text-lg"><%= property.address %></p>
      </div>
      <div class="py-2">
        <.button type="button" phx-click="add_note" phx-value-property-id={property.id}>
          Add Note
        </.button>
        <.button type="button" phx-click="manage_property" phx-value-property-id={property.id}>
          Manage
        </.button>
      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    properties = Property.get_all!()

    {:ok, assign(socket, properties: properties)}
  end

  def handle_event("add_note", %{"property-id" => property_id}, socket) do
    {:noreply, redirect(socket, to: ~p"/properties/#{property_id}/add_note")}
  end

  def handle_event("manage_property", %{"property-id" => property_id}, socket) do
    {:noreply, redirect(socket, to: ~p"/properties/#{property_id}")}
  end
end
