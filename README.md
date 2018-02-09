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
