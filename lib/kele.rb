require 'httparty'
require 'json'

class Kele
  include HTTParty

  def initialize(email, password)
    reply = self.class.post(api_url("sessions"), body: { email: email, password: password } )
    @auth_token = reply['auth_token']
  end

  def get_me
    reply = self.class.get(api_url("users/me"), headers: { "authorization" => @auth_token })
    readable = JSON.parse(reply.body)
    mentor = readable["current_enrollment"]
    mentor_id = mentor["mentor_id"]
  end

  def get_mentor_availability(mentor_id)
    reply = self.class.get(api_url("mentors/#{mentor_id}/student_availability"), headers: {"austhorization" => @auth_token})
    readable = JSON.parse(reply.body)
  end

  private
    def api_url(endpoint)
      "https://www.bloc.io/api/v1/#{endpoint}"
    end
end
