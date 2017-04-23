RSpec.configure do |config|
  config.include Features::SessionHelpers, type: :feature
  config.include Features::FormHelpers,    type: :feature
  config.include Features::WaitForAjax,    type: :feature
end
