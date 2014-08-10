class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  # :confirmable, :lockable, :timeoutable and :omniauthable

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "https://dl.dropboxusercontent.com/s/sm3ja2rreztsaj4/blue_dropbox_glyph-vflJ8-C5d.jpg"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def full_name
    [first_name, last_name].join("  ")
  end



  validates :user_name, presence: true
#JQ - should have only 1 challenge, change later!
  has_many :challenges, dependent: :destroy
  has_many :payments
  has_many :banks
  has_many :withdraws

  #JQ - this is your users controller, it tells your "class" payment, that user id is instead player_id or host_id****foreign key says "seller_id replaced with host_id, sales replaced with history"
  has_many :history, class_name: "payment", foreign_key: "player_id"
  has_many :history, class_name: "payment", foreign_key: "host_id"
  has_many :questions, dependent: :destroy
  #not sure if you want to delete a commen if user is deleted^
end