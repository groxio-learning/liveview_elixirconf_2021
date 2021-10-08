defmodule Memorex.Repo.Migrations.CreatePassages do
  use Ecto.Migration

  def change do
    create table(:passages) do
      add :slug, :string
      add :phrase, :text
      add :steps, :integer

      timestamps()
    end

  end
end
