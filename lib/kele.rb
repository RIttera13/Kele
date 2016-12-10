require './lib/module/roadmap'
require 'httparty'
require 'json'
require 'pry'

class Kele
  include HTTParty
  include Roadmap

  base_uri "https://www.bloc.io/api/v1/"

  def initialize(email, password)
    reply = self.class.post(api_url("sessions"), body: { email: email, password: password })
    @auth_token = reply['auth_token']
  end

  def get_me
    reply = self.class.get(api_url("users/me"), headers: { "authorization" => @auth_token })
    body = JSON.parse(reply.body)
  end

  def get_mentor_availability(mentor_id)
    reply = self.class.get(api_url("mentors/#{mentor_id}/student_availability"), headers: {"austhorization" => @auth_token})
    body = JSON.parse(reply.body)
  end

  def get_messages(arg = nil)
    reply = self.class.get(api_url("message_threads"), headers: { "authorization" => @auth_token })
    body = JSON.parse(reply.body)
    pages = (1..(reply["count"]/10 + 1)).map do |n|
      self.class.get(api_url("message_threads"), body: { page: n }, headers: { "authorization" => @auth_token })
    end
  end

  def create_message(sender, recipient_id, token, subject, stripped)
    options = {body: {sender: sender, recipient_id: recipient_id, token: nil, subject: subject, stripped: stripped}, headers: { "austhorization" => @auth_token }}
    self.class.post(api_url("messages"), options)
  end

  def create_submission(assignment_branch, assignment_commit_link, checkpoint_id, comment, enrollment_id)
    options = {body: {assignment_branch: assignment_branch, assignment_commit_link: assignment_commit_link, checkpoint_id: checkpoint_id, comment: comment, enrollment_id: enrollment_id}, headers: { "authorization" => @auth_token }}
    self.class.post(api_url("checkpoint_submissions"), options)
  end

  private
    def api_url(endpoint)
      "https://www.bloc.io/api/v1/#{endpoint}"
    end
end
