class Repository < ActiveRecord::Base
  has_many :repository_files, dependent: :destroy
  has_many :notes, dependent: :destroy
	belongs_to :user
end
