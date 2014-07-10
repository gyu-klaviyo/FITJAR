class AddPoolToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :pool, :integer
  end
end
