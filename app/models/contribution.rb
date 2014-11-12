class Contribution < ActiveRecord::Base
	belongs_to :contributor
	belongs_to :repository_file
end