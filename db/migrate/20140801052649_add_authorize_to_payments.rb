class AddAuthorizeToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :authorize, :string
  end
end
