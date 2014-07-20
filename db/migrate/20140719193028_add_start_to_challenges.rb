class AddStartToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :start, :date
  end
end
