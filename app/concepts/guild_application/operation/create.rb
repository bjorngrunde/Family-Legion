class GuildApplication::Create < Trailblazer::Operation

  step Nested(:build!)
  step Contract::Validate(key: :guild_application)
  step :set_status_to_pending!
  step :upload_screenshot!
  step Contract::Persist()


  private
  def set_status_to_pending!(options, **)
    options["model"].status = :pending
  end

  def upload_screenshot!(options, **)
    return true if options["contract.default"].screenshot.nil?
    options["contract.default"].image!(options["contract.default"].screenshot) do |v|
      v.process!(:original)
      v.process!(:thumb) { |job| job.thumb!("120x120#") }
    end
  end

  def build!(options, **)
    GuildApplication::New
  end
end