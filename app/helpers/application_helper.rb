module ApplicationHelper
  def current_user
    @user ||= User.find_by(id: session[:user_id])
  end

  def user_logged_in?
    current_user
  end

  def repository_exists?(repository_name, repo_owner_name)
  	Repository.find_by(name: repository_name, repo_owner: repo_owner_name)
  end
end

