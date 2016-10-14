defmodule Retro.Repo.Migrations.CreateCard do
  use Ecto.Migration

  def change do
    create table(:cards, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :title, :string

      timestamps()
    end

  end
end
