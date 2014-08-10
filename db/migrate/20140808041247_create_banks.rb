class CreateBanks < ActiveRecord::Migration
  def change
    create_table :banks do |t|
      t.string :bank

      t.timestamps
    end
  end
end
