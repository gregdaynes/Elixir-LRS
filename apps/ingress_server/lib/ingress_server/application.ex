defmodule IngressServer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Plug.Adapters.Cowboy.child_spec(scheme: :http, plug: IngressServer.Router, options: [port: 8085]),
      %{
        id: IngressServer.RMQPublisher,
        start: {IngressServer.RMQPublisher, :start_link, []}
      },
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: IngressServer.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
