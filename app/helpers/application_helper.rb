 module ApplicationHelper
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def user_logged_in?
    current_user
  end

  def delete_repo(repo_name)
    `cd /tmp && rm -rf #{repo_name}`
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    direction =  column == sort_column && sort_direction == "desc" ? "asc" : "desc"
    link_to title, sort: column, direction: direction
  end

  def last_checked(repository)
    if repository.updated_at
      repository.updated_at
    else
      repository.created_at
    end
  end

end
