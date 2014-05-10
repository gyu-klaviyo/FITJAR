class AddFieldsToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :player_id, :integer
    add_column :payments, :host_id, :integer
  end
end
