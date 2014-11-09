class Repository < ActiveRecord::Base
	validates :name, uniqueness: true
	validates :url, uniqueness: true

  has_many :project_files
	belongs_to :user
end
