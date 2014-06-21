class AddLastNameToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :last_name, :string
  end
end
