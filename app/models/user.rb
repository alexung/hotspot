class User < ActiveRecord::Base
	has_many :repositories
	has_many :docs, through: :repositories
end
