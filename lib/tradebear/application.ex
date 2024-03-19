defmodule Tradebear.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      TradebearWeb.Telemetry,
      Tradebear.Repo,
      {DNSCluster, query: Application.get_env(:tradebear, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Tradebear.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Tradebear.Finch},
      # Start a worker by calling: Tradebear.Worker.start_link(arg)
      # {Tradebear.Worker, arg},
      # Start to serve requests, typically the last entry
      TradebearWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Tradebear.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TradebearWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
