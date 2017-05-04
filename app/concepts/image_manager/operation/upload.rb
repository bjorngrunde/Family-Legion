class ImageManager::Upload < Trailblazer::Operation

  step Model(ImageManager, :new)
  step Contract::Build(constant: ImageManager::Contract::Upload)
  step Contract::Validate()
  step :upload_image!
  step :add_user!
  step Contract::Persist()

  def upload_image!(options, params:, **)
    options["model"].image(options["contract.default"].file) do |v|
      v.process!(:original)
    end
  end

  def add_user!(options, **)
    options["model"].user = options["current_user"]
  end
end
