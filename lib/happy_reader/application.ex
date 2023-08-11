defmodule HappyReader.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      HappyReaderWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: HappyReader.PubSub},
      # Start Finch
      {Finch, name: HappyReader.Finch},
      # Start the Endpoint (http/https)
      HappyReaderWeb.Endpoint
      # Start a worker by calling: HappyReader.Worker.start_link(arg)
      # {HappyReader.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HappyReader.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    HappyReaderWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
