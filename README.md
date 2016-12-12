# Kele

This is a basic gem created to access the Bloc API. This was included in the Bloc curriculum as a project creating a gem.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'kele'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kele

## Usage

### To login as a bloc user and get an Authorization Token.

initialize(email, password)
 
### You can return the user info assigned to the credentials used in initialization.

get_me
   
### To access the current users mentor schedule.

get_mentor_availability(mentor_id)

### To access the current users messages; the all message threads endpoint returns message threads paginated with 10 threads per page and a total count of all threads. Either return a specified page or retrieve all message threads through multiple calls to the endpoint.

get_messages(page_number)

### To create a message from the current user.

create_message(sender, recipient_id, token, subject, stripped)
  
### To create a submission from the current user.

create_submission(assignment_branch, assignment_commit_link, checkpoint_id, comment, enrollment_id)

### This will allow the current user to update a submission already made.

submission_update(id, assignment_branch, assignment_commit_link, checkpoint_id, comment, enrollment_id)

### Returns the roadmap associated to an input user_id.

get_roadmap(roadmap_id)

### To return a specific checkpoint, a checkpoint_id will need to be supplied. 

get_checkpoint(checkpoint_id)

## Development

This can be tested using IRB. Require the kele.rb and try the different methods listed above.

## Contributing

This gem is not actively managed or updated.
