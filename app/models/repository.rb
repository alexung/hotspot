class Repository < ActiveRecord::Base
  has_many :project_files
	belongs_to :user
end
