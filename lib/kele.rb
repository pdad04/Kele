require 'httparty'

class Kele
  include HTTParty

  def initialize(username, password)
    @api_url = 'https://www.bloc.io/api/v1'

    options = {
      body: {
        email: username,
        password: password
      }
    }

    response = self.class.post "#{@api_url}/sessions", options

    puts response.parsed_response["message"] if response.parsed_response


    @auth_token = response["auth_token"]
  end
end
