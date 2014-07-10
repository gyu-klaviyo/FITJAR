class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true
#JQ - should have only 1 challenge, change later!
  has_many :challenges, dependent: :destroy

  #JQ - this is your users controller, it tells your "class" payment, that user id is instead player_id or host_id****foreign key says "seller_id replaced with host_id, sales replaced with history"
  has_many :history, class_name: "payment", foreign_key: "player_id"
  has_many :history, class_name: "payment", foreign_key: "host_id"
  has_many :questions
end