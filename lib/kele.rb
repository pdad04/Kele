require 'httparty'
require 'json'

class Kele
  include HTTParty
  base_uri 'https://www.bloc.io/api/v1'

  def initialize(username, password)

    # Configure options for obtaining auth token
    options = {
      body: {
        email: username,
        password: password
      }
    }

    # Retrieve Auth Token
    response = self.class.post('/sessions', options)

    puts response.parsed_response["message"] if response.parsed_response

    @auth_token = response["auth_token"]
  end

  # Request current user
  def get_me
    response = self.class.get('/users/me', headers: { "authorization" => @auth_token})

    @current_user = JSON.parse(response.body)

    puts @current_user["error"] if @current_user["error"]
  end
end
