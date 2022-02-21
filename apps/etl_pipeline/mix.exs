defmodule ETLPipeline.MixProject do
  use Mix.Project

  def project do
    [
      app: :etl_pipeline,
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
      mod: {ETLPipeline.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:jason, "~> 1.3"},
      {:broadway, "~> 1.0"},
      {:broadway_rabbitmq, "~> 0.7.2"},
      {:ecto_sql, "~> 3.7"},
      {:postgrex, "~> 0.16.1"},
      {:gen_rmq, github: "meltwater/gen_rmq", commit: "ae6958c"}
    ]
  end
end
