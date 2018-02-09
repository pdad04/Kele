module Roadmap
  def get_roadmap(id)
    response = self.class.get("/roadmaps/#{id}")

    JSON.parse(response.body)
  end

  def get_checkpoint(id)
    response = self.class.get("/checkpoints/#{id}", headers: { "authorization" => @auth_token })

    JSON.parse(response.body)

  end
end
