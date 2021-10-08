defmodule Memorex.Library.Passage do
  use Ecto.Schema
  import Ecto.Changeset

  schema "passages" do
    field :phrase, :string
    field :slug, :string
    field :steps, :integer

    timestamps()
  end

  @doc false
  def changeset(passage, attrs) do
    passage
    |> cast(attrs, [:slug, :phrase, :steps])
    |> validate_required([:slug, :phrase, :steps])
    |> validate_length(:slug, min: 4, max: 8)
  end
end
