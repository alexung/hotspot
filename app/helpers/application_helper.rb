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

  def render_seg(lines, adds, dels)
    [
      lines - dels,
      adds,
      dels,
    ]
  end

  def set_value_against_max(rendered_segments)
    rendered_segments.each do |triple|
      sum_lines = triple.reduce(:+)
      triple.map! do |value|
        if sum_lines == 0
          0
        else
          ((value/sum_lines.to_f)*10).to_i.abs
        end
      end
    end
  end

  def parse_css_perc(graph_arr)
    lines = 0
    sum_lines = 0
    rendered_segments = []

    graph_arr.each do |adds, dels|
      rendered_segments << render_seg(lines, adds, dels)
      lines = (lines + adds) - dels
    end
    set_value_against_max(rendered_segments).reverse
  end

end
