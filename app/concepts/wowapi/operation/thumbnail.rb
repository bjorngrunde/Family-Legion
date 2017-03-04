class Wowapi::Thumbnail < Trailblazer::Operation

  step :download_thumbnail!

  def download_thumbnail!(options, alt:, **)
    character = RBattlenet::Wow::Character.find(name: alt.name, realm: alt.server)
    options["thumbnail"] = open("http://render-eu.worldofwarcraft.com/character/#{character["thumbnail"]}").read
    #raise options["thumbnail"].inspect
  end
end