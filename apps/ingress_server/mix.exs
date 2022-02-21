defmodule IngressServer.MixProject do
  use Mix.Project

  def project do
    [
      app: :ingress_server,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {IngressServer.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:cowboy, "~> 1.0"},
      {:jason, "~> 1.3"},
      {:plug, "~> 1.13"},
      {:plug_cowboy, "~> 1.0"},
      {:gen_rmq, github: "meltwater/gen_rmq", commit: "ae6958c"}
    ]
  end
end
