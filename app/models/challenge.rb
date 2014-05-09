class Challenge < ActiveRecord::Base
	  
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

#belongs to HOST
  		belongs_to :user
	end



