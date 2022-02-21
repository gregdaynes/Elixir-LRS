defmodule ETLPipeline.RMQPublisher do
  @behaviour GenRMQ.Publisher

  @rmq_uri "amqp://rabbitmq:rabbitmq@localhost:5672"
  @lrs_exchange "lrs_exchange"
  @lrs_ingress_queue "lrs_ingress_queue"
  @publish_options [persistent: false]

  def init do
    create_rmq_resources()

    [
      uri: @rmq_uri,
      exchange: @lrs_exchange
    ]
  end

  def start_link do
    GenRMQ.Publisher.start_link(__MODULE__, name: __MODULE__)
  end

  def lrs_ingress_queue_size do
    GenRMQ.Publisher.message_count(__MODULE__, @lrs_ingress_queue)
  end

  def publish_lrs_ingress_item(record) do
    GenRMQ.Publisher.publish(__MODULE__, record, @lrs_ingress_queue, @publish_options)
  end

  def lrs_ingress_queue_name, do: @lrs_ingress_queue

  defp create_rmq_resources do
    {:ok, connection} = AMQP.Connection.open(@rmq_uri)
    {:ok, channel} = AMQP.Channel.open(connection)

    AMQP.Exchange.declare(channel, @lrs_exchange, :topic, durable: true)
    AMQP.Queue.declare(channel, @lrs_ingress_queue, durable: true)
    AMQP.Queue.bind(channel, @lrs_ingress_queue, @lrs_exchange, routing_key: @lrs_ingress_queue)

    AMQP.Channel.close(channel)
  end
end
