require './lib/module/roadmap'
require 'httparty'
require 'json'
require 'pry'

class Kele
  include HTTParty
  include Roadmap

  def initialize(email, password)
    reply = self.class.post(api_url("sessions"), body: { email: email, password: password } )
    @auth_token = reply['auth_token']
  end

  def get_me
    reply = self.class.get(api_url("users/me"), headers: { "authorization" => @auth_token })
    @user_info = JSON.parse(reply.body)
    @user_info.keys.each do |key|
      self.class.send(:define_method, key.to_sym) do
         @user_info[key]
      end
    end
    binding.pry
    @user_info
  end

  def get_mentor_availability(mentor_id)
    reply = self.class.get(api_url("mentors/#{mentor_id}/student_availability"), headers: {"austhorization" => @auth_token})
    @mentor = JSON.parse(reply.body)
  end

  private
    def api_url(endpoint)
      "https://www.bloc.io/api/v1/#{endpoint}"
    end
end
