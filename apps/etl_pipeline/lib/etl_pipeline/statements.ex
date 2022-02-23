defmodule ETLPipeline.Statements do
  use Ecto.Schema

  import Ecto.Changeset

  schema "statements" do
    field(:data, :map)

    timestamps([updated_at: false])
  end

  def changeset(statement, params \\ %{}) do
    all_fields = ~w(data)a

    statement
    |> cast(params, all_fields)
    |> validate_required(all_fields)
  end
end
