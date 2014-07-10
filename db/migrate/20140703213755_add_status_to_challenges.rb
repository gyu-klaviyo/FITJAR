class AddStatusToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :status, :boolean
  end
end
