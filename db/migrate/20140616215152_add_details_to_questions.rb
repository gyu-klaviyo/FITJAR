class AddDetailsToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :details, :string
  end
end
