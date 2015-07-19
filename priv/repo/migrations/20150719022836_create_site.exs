defmodule LinkExtractorWeb.Repo.Migrations.CreateSite do
  use Ecto.Migration

  def change do
    create table(:sites) do
      add :title, :string
      add :url, :string

      timestamps
    end

  end
end
