defmodule TradebearWeb.PropertyManagement.AddContactLive do
  use TradebearWeb, :live_view
  alias Tradebear.PropertyManagement.Contact

  def render(assigns) do
    ~H"""
    <h2 class="py-5">Create Contact for Client <%= @client.name %></h2>
    <.form for={@form} phx-change="validate_contact" phx-submit="create_contact">
      <.input type="text" field={@form[:name]} label="Name" autofocus />
      <.input type="text" field={@form[:email]} label="Email" />
      <.input type="text" field={@form[:phone]} label="Phone" />
      <.input type="text" field={@form[:address]} label="Address" />
      <button class="btn mt-2">Create</button>
    </.form>
    """
  end

  def mount(%{"id" => client_id}, _session, socket) do
    client = Tradebear.PropertyManagement.Client.get_by_id!(client_id)

    form =
      AshPhoenix.Form.for_create(Contact, :create, api: Tradebear.PropertyManagement)
      |> to_form()

    {:ok, assign(socket, form: form, client: client)}
  end

  def handle_event("validate_contact", %{"form" => contact_params}, socket) do
    form = AshPhoenix.Form.validate(socket.assigns.form, contact_params)
    {:noreply, assign(socket, form: form)}
  end

  def handle_event("create_contact", %{"form" => contact_params}, socket) do
    contact_params = Map.put(contact_params, :client_id, socket.assigns.client.id)

    case AshPhoenix.Form.submit(socket.assigns.form, params: contact_params) do
      {:ok, contact} ->
        Contact.link_to_client(contact, contact_params.client_id, false)
        {:noreply, redirect(socket, to: ~p"/clients/#{socket.assigns.client.id}")}

      {:error, form} ->
        {:noreply, assign(socket, form: form)}
    end
  end
end
