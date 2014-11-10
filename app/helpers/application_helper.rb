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
  
  def avatar_url(gh_email)
    default_url = "http://www.gravatar.com/avatar/00000000000000000000000000000000?s=30"
    gravatar_id = Digest::MD5.hexdigest(gh_email.downcase)
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=30&d=#{CGI.escape(default_url)}"
  end
end