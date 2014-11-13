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

  # def example_bar_graph_method(type, total_scale)
  #   tuple_value = find the value of the tuple
  #   find the type of tuple (addition, subtraction, or unchanged)
  #   tuple % = divide the tuple_value by the total_scale
  #   tuple % ends up assigning a css class based on outcome(i.e. additions-10, deletions-30, unchanged-40)
  # end
  # [[1,2],[2,3],[3,4]]

  # def additions(value, total_scale)
  #   tuple_value = find the value of the tuple
  #   tuple % = divide the tuple_value by the total_scale
  #   #tuple % ends up assigning a green css class based on outcome(i.e. additions-10, deletions-30, unchanged-40)
  # end

  # def deletions(value, total_scale)
  #   tuple_value = find the value of the tuple
  #   tuple_% = divide the tuple_value by the total_scale
  #   #tuple % ends up assigning a red css class based on outcome(i.e. additions-10, deletions-30, unchanged-40)
  # end

  # def unchanged(unchanged_argument, total_scale)
  #   tuple_value = find the value of the tuple
  #   unchanged_argument - (additions + subtractions)
  #   tuple_% = divide the unchanged_argument by the total_scale
  #   #tuple % ends up assigning a black css class based on outcome(i.e. additions-10, deletions-30, unchanged-40)
  # end

  # def unchanged_argument
  #   add the additions & deletions from the last commit
  # end

end
