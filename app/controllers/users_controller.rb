class UsersController < ApplicationController

  def index
  end

  def auth
  	redirect_to client.auth_code.authorize_url(:redirect_uri => 'http://localhost:3000/oauth-callback',:scope => 'https://www.googleapis.com/auth/userinfo.email',:access_type => "offline")
  end

  def callback
    #Gets the Access Token for the User Signed In and Stores it
    access_token = client.auth_code.get_token(params[:code], :redirect_uri => 'http://localhost:3000/callback')
    #Stores all the Information that Google Sends Back In Variable For Later Use
    google_profile = access_token.get('https://www.googleapis.com/oauth2/v1/userinfo?alt=json')
    #Gets the Info Specifically About the signed in User
    user_info = JSON.parse(google_profile.body)
    emails = JSON.parse(google_profile.body)
    #Using the Information Google Sent Back Look for or create the User
    @user = User.find_or_create_by(email: user_info["email"])
    @user.update(name: user_info["name"] , email: user_info["email"], photo: user_info["picture"], oauthtoken: access_token.token, oauthrefresh: access_token.refresh_token)
    #Assign the User a Session
    session[:user_id] = @user.id
    redirect_to '/'
  end

end
