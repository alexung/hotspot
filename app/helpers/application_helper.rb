module ApplicationHelper

  CLIENT_ID = ENV['CLIENT_ID']
  CLIENT_SECRET = ENV['CLIENT_SECRET']

  def client
    client ||= OAuth2::Client.new(CLIENT_ID, CLIENT_SECRET, {
              :client_id => CLIENT_ID,	
              :client_secret => CLIENT_SECRET,
              :authorize_url => "https://github.com/login/oauth/authorize"
            })
  end
end