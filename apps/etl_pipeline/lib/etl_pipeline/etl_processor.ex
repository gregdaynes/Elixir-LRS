defmodule ETLPipeline.ETLProcessor do
  use Broadway

  require Logger

  alias Broadway.Message

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
  def handle_message(_processor, %Broadway.Message{data: data} = message, _context) do
    data
    |> Jason.decode!
    |> Kernel.inspect
    |> Logger.info

    message
  end
end
