class UsersController < ApplicationController
  include ApplicationHelper

  def show
    @user = User.find(session[:user_id])
    @repositories = @user.repositories
  end

   def destroy
    @repositories = User.find(params["id"]).repositories
    delete_repo(repository.name)
    repository.destroy
    #@repository = Repository.find(params[:id])
    # delete from /tmp
    #delete_repo(@repository.name)
    #@repository.destroy
    redirect_to user_path(User.find(session[:user_id]))
  end

	private

	def user_params
		params.require(:user).permit(:avatar_url, :email, :name)
	end
end
