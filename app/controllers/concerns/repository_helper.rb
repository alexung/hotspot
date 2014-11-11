module RepositoryHelper

  extend ActiveSupport::Concern
  include CodeReviewHelper

  def repository_exists?(repo_uid)
  	Repository.find_by(repo_uid: repo_uid)
  end
end

