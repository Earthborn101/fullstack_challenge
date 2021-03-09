defmodule FullstackChallenge.Repo.Migrations.AlterPersonTableAddNameGroup do
  use Ecto.Migration

  def up do
    alter table(:person) do
      add :name_group, :string, size: 2
    end
  end

  def down do
    alter table(:person) do
      remove :name_group
    end
  end
end
