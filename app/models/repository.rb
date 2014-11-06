class Repository < ActiveRecord::Base
  has_many :docs
	belongs_to :user
end
