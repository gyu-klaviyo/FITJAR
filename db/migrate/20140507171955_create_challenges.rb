class CreateChallenges < ActiveRecord::Migration
  def change
    create_table :challenges do |t|
      t.string :name
      t.text :description
      t.decimal :stake
      t.decimal :duration

      t.timestamps
    end
  end
end
