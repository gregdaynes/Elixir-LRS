defmodule IngressServerTest do
  use ExUnit.Case
  doctest IngressServer

  test "greets the world" do
    assert IngressServer.hello() == :world
  end
end
