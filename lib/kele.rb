require 'httparty'
require 'json'
require'./lib/roadmap'

class Kele
  include HTTParty
  include Roadmap

  base_uri 'https://www.bloc.io/api/v1'

  def initialize(username, password)

    # Configure options for obtaining auth token
    options = {
      body: {
        email: username,
        password: password
      }
    }

    response = self.class.post('/sessions', options)

    puts response.parsed_response["message"] if response.parsed_response

    @auth_token = response["auth_token"]
  end

  def get_me
    response = self.class.get('/users/me', headers: { "authorization" => @auth_token})

    JSON.parse(response.body)
  end

  def get_mentor_availability(id)
    response = self.class.get("/mentors/#{id}/student_availability?id=#{id}", headers: { "authorization" => @auth_token})

    JSON.parse(response.body)
  end
end
