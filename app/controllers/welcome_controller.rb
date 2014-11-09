class WelcomeController < ApplicationController
  def index
    @home_banner = true
  	@repositories = Repository.where(user_id: session[:user_id])
    @notes = Note.all
  end
end
