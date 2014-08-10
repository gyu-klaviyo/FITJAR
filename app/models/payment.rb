class Payment < ActiveRecord::Base

#validates :address, :city, :state, presence: true

  belongs_to :challenge
  belongs_to :user

  #JQtells you that host is a kind of user, and player is a kind  of user
  belongs_to :host, class_name: "User"
  belongs_to :player, class_name: "User"
end
