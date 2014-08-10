class CreateWithdraws < ActiveRecord::Migration
  def change
    create_table :withdraws do |t|
      t.integer :amount

      t.timestamps
    end
  end
end
