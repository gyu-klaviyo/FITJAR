class AddChallengeIdToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :challenge_id, :integer
  end
end
