module Roadmap
  def get_roadmap(roadmap_id)
    reply = self.class.get(api_url("roadmaps/#{roadmap_id}"), headers: {"authorization" => @auth_token})
    @roadmap = JSON.parse(reply.body)
  end

  def get_checkpoint(checkpoint_id)
    reply = self.class.get(api_url("checkpoints/#{checkpoint_id}"), headers: {"authorization" => @auth_token})
    @checkpoint = JSON.parse(reply.body)
  end
end
