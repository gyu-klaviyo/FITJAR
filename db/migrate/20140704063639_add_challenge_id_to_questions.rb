class AddChallengeIdToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :challenge_id, :string
  end
end
