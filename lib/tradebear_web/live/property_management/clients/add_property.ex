defmodule TradebearWeb.PropertyManagement.AddPropertyLive do
  use TradebearWeb, :live_view
  alias Tradebear.PropertyManagement.Property

  def render(assigns) do
    ~H"""
    <h2 class="py-5">Create Property for Client <%= @client.name %></h2>
    <.form for={@form} phx-change="validate_property" phx-submit="create_property">
      <.input type="text" field={@form[:address]} label="Address" autofocus />
      <button class="btn mt-2">Create</button>
    </.form>
    """
  end

  def mount(%{"id" => client_id}, _session, socket) do
    client = Tradebear.PropertyManagement.Client.get_by_id!(client_id)

    form =
      AshPhoenix.Form.for_create(Property, :create, api: Tradebear.PropertyManagement)
      |> to_form()

    {:ok, assign(socket, form: form, client: client)}
  end

  def handle_event("validate_property", %{"form" => property_params}, socket) do
    form = AshPhoenix.Form.validate(socket.assigns.form, property_params)
    {:noreply, assign(socket, form: form)}
  end

  def handle_event("create_property", %{"form" => property_params}, socket) do
    property_params = Map.put(property_params, :client_id, socket.assigns.client.id)

    case AshPhoenix.Form.submit(socket.assigns.form, params: property_params) do
      {:ok, _property} ->
        {:noreply, redirect(socket, to: ~p"/clients/#{socket.assigns.client.id}")}

      {:error, form} ->
        {:noreply, assign(socket, form: form)}
    end
  end
end
