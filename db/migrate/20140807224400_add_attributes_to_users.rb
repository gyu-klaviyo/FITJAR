class AddAttributesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :date_of_birth, :date
    add_column :users, :gender, :string
    add_column :users, :height, :string
    add_column :users, :weight, :integer
    add_column :users, :activity, :string
  end
end
