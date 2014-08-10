class AddUserIdToWithdraws < ActiveRecord::Migration
  def change
    add_column :withdraws, :user_id, :integer
    add_column :withdraws, :bank_id, :integer
  end
end
