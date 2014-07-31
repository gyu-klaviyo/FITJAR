class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :users, :username, :user_name
    rename_column :users, :name, :first_name
  end
end