# Kele

## Bloc API Client

## About
* Kele is a Ruby Gem API client to access the [Bloc](https://www.bloc.io) API. This Gem provides a way to easily access and use the student endpoints of Bloc's API.

## Requirements
* A [Bloc](https://www.bloc.io) username and password.

## Examples
- Initialize and authorize a Kele Client
```ruby
kele_client = Kele.new('andy@example.com','password')
```

- You can retrieve the current user as ruby hash like so
```ruby
kele_client.get_me
```

- To get a mentors availability
```ruby
# mentor_id can be grabbed from the hash returned from #get_me
kele_client.get_mentor_availability(mentor_id)
```

- To get the roadmap
```ruby
  # id is returned in #get_me response.
  # It is current_program_module =>{roadmap_id}
  kele_client.get_roadmap(id)
```

- To get the checkpoints
```ruby
  # id of checkpoint is in #get_roadmap response
  # in ckpoints => [{id},{...},{...},]
  kele_client.get_checkpoint(id)
```

- To create a new message
```ruby
  # You will need to pass a sender(String), mentor_id(Integer), subject(String), message body(String)
  # mentor_id can be found in the #get_me response.
  kele_client.create_message('jane@example.com', 23422,'Message Subject', 'Body of the message')
```

- To create a new thread on existing message
```ruby
# You will need to pass a sender(String), mentor_id(Integer), subject(String), message body(String), message token(String)
# mentor_id can be found in the #get_me response. messag token is in #get_messages response => {"token": }
kele_client.create_message('jane@example.com', 23422,'Message Subject', 'Body of the message', '70ba46bd-25d8-478z-9eaf-34eaa4e5e421')
```
- To create a checkpoint submission
```ruby
# Pass in the checkpoint_id (#get_roadmap response), assignment branch name, assignment commit link, comment, and the enrollment_id (this is found in #get_me response in the current_enrollment hash)
kele_client.create_submission(2142, "checkpointSubmission", "https://github.com/.../.../", "Testing 'create_submission'", 33442)
```
