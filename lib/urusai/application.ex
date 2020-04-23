defmodule Urusai.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Urusai.Repo,
      # Start the Telemetry supervisor
      UrusaiWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Urusai.PubSub},
      # Start the Endpoint (http/https)
      UrusaiWeb.Endpoint
      # Start a worker by calling: Urusai.Worker.start_link(arg)
      # {Urusai.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Urusai.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    UrusaiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
