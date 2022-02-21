defmodule IngressServer.Router do
  use Plug.Router
  use Plug.Debugger

  require Logger

  plug(Plug.Logger, log: :debug)
  plug(:match)
  plug(:dispatch)

  get "/" do
    send_resp(conn, 200, "welcome")
  end

  post "/" do
    {:ok, body, conn } = read_body(conn)
    {:ok, data} = Jason.decode(body)
    send_resp(conn, 201, Jason.encode!(data))
  end

  match _ do
    send_resp(conn, 404, "not found")
  end
end
