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

  def get_messages(page = nil)
    if page
      response = self.class.get("/message_threads?page=#{page}", headers: { "authorization" => @auth_token })
    else
      response = self.class.get("/message_threads", headers: { "authorization" => @auth_token})
    end

    JSON.parse(response.body)
  end

  def create_message(sender, id, subject, body, token = nil)
    if token
      msg_data = {
        body: {
          'sender': sender,
          'recipient_id': id,
          'token': token,
          'subject': subject,
          'stripped-text': body

        }
      }
    else
      msg_data = {
        body: {
          'sender': sender,
          'recipient_id': id,
          'subject': subject,
          'stripped-text': body
        },
        headers:{ "authorization" => @auth_token}
      }
    end

    response = self.class.post('/messages', msg_data)
  end

  def create_submission(checkpoint_id, assignment_branch, assignment_commit_link, comment, enrollment_id)
    options = {
      body: {
        "assignment_branch": assignment_branch,
        "assignment_commit_link": assignment_commit_link,
        "checkpoint_id": checkpoint_id,
        "comment": comment,
        "enrollment_id": enrollment_id
      },
      headers: {"authorization" => @auth_token}
    }

    response = self.class.post('/checkpoint_submissions', options)
  end
end
