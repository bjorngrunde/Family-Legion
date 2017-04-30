class Dungeon::Update < Trailblazer::Operation

  step Nested(:build!)
  step Contract::Validate(key: :dungeon)
  step :upload_image!
  step Contract::Persist()

  def upload_image!(options, **)
    return true if options["contract.default"].dungeon_image.nil?

    options["contract.default"].image!(options["contract.default"].dungeon_image) do |v|
      v.process!(:original)
      v.process!(:thumbnail) { |job| job.thumb!("300x300+20+20") }
    end
  end

  def build!(options, **)
    Dungeon::Edit
  end
end
