defmodule Marely.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      # Marely.Repo, 
      # Start the Telemetry supervisor
      MarelyWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Marely.PubSub},
      # Start the Endpoint (http/https)
      MarelyWeb.Endpoint
      # Start a worker by calling: Marely.Worker.start_link(arg)
      # {Marely.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Marely.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    MarelyWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
