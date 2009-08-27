class Task < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :project
  
  acts_as_list :scope => :user

end
