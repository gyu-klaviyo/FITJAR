class Bank < ActiveRecord::Base
	belongs_to :user
	has_many :withdraws
end
