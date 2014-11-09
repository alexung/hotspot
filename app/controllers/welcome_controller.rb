class WelcomeController < ApplicationController
  def index
  	@repositories = Repository.where(user_id: session[:user_id])
    @notes = Note.all
  end
end
