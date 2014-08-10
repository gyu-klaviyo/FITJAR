class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :device

      t.timestamps
    end
  end
end
