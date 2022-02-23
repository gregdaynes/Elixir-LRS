defmodule ETLPipeline.ETLProcessor do
  use Broadway

  require Logger

  alias Broadway.Message
  alias ETLPipeline.{Statements, Repo}

  def start_link(_opts) do
    Broadway.start_link(__MODULE__,
      name: __MODULE__,
      producer: [
        module:
        {BroadwayRabbitMQ.Producer,
          queue: ETLPipeline.RMQPublisher.lrs_ingress_queue_name(),
          connection: [
            username: "rabbitmq",
            password: "rabbitmq"
          ]},
        concurrency: 1
      ],
      processors: [
        default: [
          concurrency: 1
        ]
      ],
    )
  end

  @impl true
  def handle_message(_processor, %Broadway.Message{data: message_data} = message, _context) do
    decoded_data = message_data
    |> Jason.decode!

    %Statements{}
    |> Statements.changeset(%{data: decoded_data})
    |> Repo.insert()

    message
  end
end
