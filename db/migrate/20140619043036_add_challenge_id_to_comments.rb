class AddChallengeIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :challenge_id, :integer
  end
end
