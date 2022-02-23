defmodule Mix.Tasks.Start do
  use Mix.Task

   @impl true
  def run(args) do
    Mix.shell().info("Hello world")
    Mix.Tasks.Run.run(open_args(args) ++ run_args())
  end

  defp iex_running? do
    Code.ensure_loaded?(IEx) and IEx.started?()
  end

  defp open_args(args) do
    if "--open" in args do
      Mix.shell().info("stuff")
      args -- ["--open"]
    else
      args
    end
  end

  defp run_args do
    if iex_running?(), do: [], else: ["--no-halt"]
  end
end
