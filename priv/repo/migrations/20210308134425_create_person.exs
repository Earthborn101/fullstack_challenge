defmodule FullstackChallenge.Repo.Migrations.CreatePerson do
  use Ecto.Migration

  def change do
    create table(:person) do
      add :name, :string
      add :percentage, :integer

      timestamps()
    end

  end
end
