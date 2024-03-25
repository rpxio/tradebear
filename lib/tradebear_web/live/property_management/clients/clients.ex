defmodule TradebearWeb.PropertyManagement.ClientsLive do
  use TradebearWeb, :live_view
  alias Tradebear.PropertyManagement.Client

  def render(assigns) do
    ~H"""
    <h2 class="text-3xl border-b border-zinc-100">Clients</h2>
    <div class="flex flex-col gap-2">
      <div
        :for={client <- @clients}
        class="flex flex-row justify-between gap-5 border-b border-zinc-100"
      >
        <div class="flex flex-col gap-1 items-left">
          <p class="text-lg"><%= client.name %></p>
          <p class="text-sm text-gray-400 max-w-60 truncate"><%= client.billing_address %></p>
        </div>
        <div class="py-2">
          <button class="btn" phx-click="manage_client" phx-value-client-id={client.id}>
            Manage
          </button>
        </div>
      </div>
      <div id="meta_client_actions" class="flex flex-row gap-5 justify-end">
        <button class="btn" phx-click="create_client">New Client</button>
      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    clients = Client.get_all!()

    {:ok, assign(socket, clients: clients)}
  end

  def handle_event("manage_client", %{"client-id" => client_id}, socket) do
    {:noreply, redirect(socket, to: ~p"/clients/#{client_id}")}
  end

  def handle_event("create_client", _args, socket) do
    {:noreply, redirect(socket, to: ~p"/clients/new")}
  end
end
