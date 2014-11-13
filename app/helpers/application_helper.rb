 module ApplicationHelper
  require 'json'

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


  # ----- BELOW IS THE GRAPH CODE ----------

# vals = [
#   [2,0], # adds, dels
#   [1,0],
#   [0,0],
#   [0,1],
#   [5,0],
#   [0,0],
#   [2,6],
#   [1,0],
#   [15,0],
#   [0,3]
# ]

def render_seg(lines, adds, dels)
  [
    lines - dels,
    adds,
    dels,
  ]
end

def parse_css_perc(graph_arr)
  lines = 0
  max_lines = 0
  rendered_segments = []

  graph_arr.each do |adds, dels|
    rendered_segments << render_seg(lines, adds, dels)
    lines = (lines + adds) - dels
    max_lines = lines if lines > max_lines
  end
  rendered_segments.reverse
end


# puts ([render_seg(lines, 0,0)]  + rendered_segments.reverse)
#parse_css_perc(vals)

# puts "max lines", max_lines
end
