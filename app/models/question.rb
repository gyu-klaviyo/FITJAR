class Question < ActiveRecord::Base



  belongs_to :user
  belongs_to :challenge

 validates :subject, :details, presence: true
  acts_as_commentable
  
end
