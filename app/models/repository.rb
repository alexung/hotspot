class Repository < ActiveRecord::Base
  has_many :repository_files
  has_many :notes
	belongs_to :user
end
