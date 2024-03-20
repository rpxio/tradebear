defmodule TradebearWeb.PropertyManagement.PropertiesLive do
  use TradebearWeb, :live_view

  def render(assigns) do
    ~H"""
    <h2 class="text-3xl">Properties</h2>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
