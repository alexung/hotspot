class Repository < ActiveRecord::Base
	validates :name, uniqueness: true
	validates :url, uniqueness: true

  has_many :repository_files
  has_many :notes
	belongs_to :user
end