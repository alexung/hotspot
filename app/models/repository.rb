class Repository < ActiveRecord::Base
  has_many :repository_files
	belongs_to :user
end
