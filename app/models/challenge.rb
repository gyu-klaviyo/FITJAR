class Challenge < ActiveRecord::Base
	  

#JQ - THIS IS FOR JARS FOR ARENA LATER, JUST COMMENT OUT FOR NOW, USE PROFILE PICTURE FOR DEVISE

  if Rails.env.development?
    has_attached_file :image, :styles => { :medium => "200x", :thumb => "100x100>" }, :default_url => "Logo-Jar.jpg"
  else
    has_attached_file :image, :styles => { :medium => "200x", :thumb => "100x100>" }, :default_url => "Logo-Jar.jpg",
        :storage => :dropbox,
        :dropbox_credentials => Rails.root.join("config/dropbox.yml"),
        :path => ":style/:id_:filename"
  	end
		validates :name, :description, :stake, presence: true
  		validates :stake, numericality: { greater_than: 0 }
  		validates_attachment_presence :image

#JQ belongs to HOST - added "has many comments"
  	acts_as_commentable

    belongs_to :user
    has_many :payments
    has_many :comments
    has_many :questions
    
    #JQ the ideanot sure what I did here!!!
  def payments_sum
    challenge_payments.sum(:value)
  end

  class  ChallengePayments < ActiveRecord::Base
    belongs_to :challenge
    validates_inclusion_of :value, :in => [-1,1]
  end

end


