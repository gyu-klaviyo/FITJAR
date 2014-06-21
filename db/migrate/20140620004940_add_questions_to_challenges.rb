class AddQuestionsToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :subject, :string
    add_column :challenges, :details, :string
  end
end
