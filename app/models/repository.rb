class Repository < ActiveRecord::Base
  has_many :repository_files, dependent: :destroy
  has_many :notes, dependent: :destroy
	validates :name, uniqueness: true
	validates :url, uniqueness: true

	belongs_to :user
end
