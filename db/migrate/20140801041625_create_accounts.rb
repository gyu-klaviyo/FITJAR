class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.date :end_date
      t.string :type
      t.string :description
      t.decimal :debit
      t.decimal :credit
      t.decimal :balance
      t.decimal :withdraw

      t.timestamps
    end
  end
end
