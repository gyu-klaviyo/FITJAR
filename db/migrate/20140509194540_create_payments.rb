class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :address
      t.string :city
      t.string :state

      t.timestamps
    end
  end
end
