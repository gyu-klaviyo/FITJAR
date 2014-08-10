class AddUserToBank < ActiveRecord::Migration
  def change
    add_column :banks, :user_id, :integer
    add_column :banks, :recipient_id, :string
  end
end
