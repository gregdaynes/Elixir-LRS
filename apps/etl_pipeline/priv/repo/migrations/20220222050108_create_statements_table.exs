defmodule ETLPipeline.Repo.Migrations.CreateStatementsTable do
  use Ecto.Migration

  @timestamps_opts [type: :utc_datetime_usec]

  def change do
    create table(:statements) do
      add :data, :map, default: %{}

      timestamps([updated_at: false])
    end
  end
end
