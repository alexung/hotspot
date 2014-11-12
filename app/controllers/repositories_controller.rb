class RepositoriesController < ApplicationController
  include GithubHelper
  include ApplicationHelper
  include RepositoryHelper
  include CodeReviewHelper

  def test
    render 'layouts/table'
  end

  def create
    redirect_to repository_path(params[:repository_id])
  end

  def show
    @repository = Repository.find(params[:id])
  end

  def update
    repository = Repository.find(params["id"])
    username = repository.repo_owner
    ` cd /tmp && rm -rf #{repository.name} `
    repository.destroy
    rows = CodeReview.new(repository.name, username).rows
    saved_repository = Repository.save_repository_to_db(
      username, 
      repository.name, 
      repository.repo_uid, 
      session[:user_id]
      )
    contributors = saved_repository.contributors.create(create_contributors_hash(saved_repository.name))

    gh_contributors = fetch_gh_contributors(username, saved_repository.name)

    contributors.map do |contributor|
      if gh_contributors.select {|gh_contributor| fetch_contributor_email(gh_contributor["login"]) }.include?(contributor.email)
        gh_info = gh_contributors.select {|gh_contributor| fetch_contributor_email(gh_contributor["login"]) == contributor.email }
          contributor.create_github_user(
            username: gh_info.first["login"], 
            gh_avatar_url: gh_info.first["avatar_url"], 
            gh_repo_url: gh_info.first["url"]
          )
      end
    end 

    rows.map do |repo_file|
      new_file =  RepositoryFile.create_repo_files(repo_file, username, saved_repository)
      repo_file[:contributors].each do |email|
        new_file.contributors << Contributor.find_by(email: email)
      end
    end
    @repository = saved_repository
    redirect_to repository_path(@repository)
  end

  def destroy
    repository = Repository.find(params[:id])
    delete_repo(repository.name)
    repository.destroy
    redirect_to user_path(User.find(session[:user_id]))
  end
end
