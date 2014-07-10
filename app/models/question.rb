class Question < ActiveRecord::Base

validates :subject, :details, presence: true
  acts_as_commentable

  belongs_to :user
  belongs_to :challenge

 
end
