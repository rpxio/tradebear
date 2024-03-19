defmodule TradebearAsh.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      TradebearAshWeb.Telemetry,
      TradebearAsh.Repo,
      {DNSCluster, query: Application.get_env(:tradebear_ash, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: TradebearAsh.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: TradebearAsh.Finch},
      # Start a worker by calling: TradebearAsh.Worker.start_link(arg)
      # {TradebearAsh.Worker, arg},
      # Start to serve requests, typically the last entry
      TradebearAshWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TradebearAsh.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TradebearAshWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
