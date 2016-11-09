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
  end

  private
    def api_url(endpoint)
      "https://www.bloc.io/api/v1/#{endpoint}"
    end

end
