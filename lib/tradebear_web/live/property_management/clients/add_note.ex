defmodule TradebearWeb.PropertyManagement.AddClientNoteLive do
  use TradebearWeb, :live_view
  alias Tradebear.PropertyManagement.Note

  def render(assigns) do
    ~H"""
    <h2 class="py-5">Create Note for Client <%= @client.name %></h2>
    <.form for={@form} phx-change="validate_note" phx-submit="create_note">
      <.input type="text" field={@form[:data]} label="Note" autofocus />
      <button class="btn mt-2">Create</button>
    </.form>
    """
  end

  def mount(%{"id" => client_id}, _session, socket) do
    client = Tradebear.PropertyManagement.Client.get_by_id!(client_id)

    form =
      AshPhoenix.Form.for_create(Note, :create, api: Tradebear.PropertyManagement)
      |> to_form()

    {:ok, assign(socket, form: form, client: client)}
  end

  def handle_event("validate_note", %{"form" => note_params}, socket) do
    form = AshPhoenix.Form.validate(socket.assigns.form, note_params)
    {:noreply, assign(socket, form: form)}
  end

  def handle_event("create_note", %{"form" => note_params}, socket) do
    note_params = Map.put(note_params, :client_id, socket.assigns.client.id)

    case AshPhoenix.Form.submit(socket.assigns.form, params: note_params) do
      {:ok, _note} ->
        {:noreply, redirect(socket, to: ~p"/clients/#{socket.assigns.client.id}")}

      {:error, form} ->
        {:noreply, assign(socket, form: form)}
    end
  end
end
