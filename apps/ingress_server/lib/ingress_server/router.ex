defmodule IngressServer.Router do
  use Plug.Router
  use Plug.Debugger

  require Logger

  alias IngressServer.RMQPublisher

  plug(Plug.Logger, log: :debug)
  plug(:match)
  plug(:dispatch)

  get "/" do
    send_resp(conn, 200, "welcome")
  end

  post "/" do
    {:ok, body, conn } = read_body(conn)
    data = body
           |> Jason.decode!()
           |> Jason.encode!()

    RMQPublisher.publish_lrs_ingress_item(data)

    send_resp(conn, 201, data)
  end

  match _ do
    send_resp(conn, 404, "not found")
  end
end
