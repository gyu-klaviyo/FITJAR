class Challenge < ActiveRecord::Base
	  

#JQ - THIS IS FOR JARS FOR ARENA LATER, JUST COMMENT OUT FOR NOW, USE PROFILE PICTURE FOR DEVISE

  if Rails.env.development?
    has_attached_file :image, :styles => { :medium => "200x", :thumb => "100x100>" }, :default_url => "https://dl.dropboxusercontent.com/s/sm3ja2rreztsaj4/blue_dropbox_glyph-vflJ8-C5d.jpg"
  else
    has_attached_file :image, :styles => { :medium => "200x", :thumb => "100x100>" }, :default_url => "https://dl.dropboxusercontent.com/s/sm3ja2rreztsaj4/blue_dropbox_glyph-vflJ8-C5d.jpg",
        :storage => :dropbox,
        :dropbox_credentials => Rails.root.join("config/dropbox.yml"),
        :path => ":style/:id_:filename"
  	end
		validates :name, :stake, :duration, presence: true
  		validates :stake, numericality: { greater_than: 0 }
        validates :duration, numericality: { greater_than: 0 }
  		#validates_attachment_presence :image > image is optional

#JQ belongs to HOST - added "has many comments"
  	acts_as_commentable

    belongs_to :user
    has_many :payments
    has_many :comments
    has_many :questions
    

end


