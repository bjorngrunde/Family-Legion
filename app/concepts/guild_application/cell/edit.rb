module GuildApplication::Cell
  class Edit < Trailblazer::Cell
    include ActionView::Helpers::TranslationHelper
    include Cell::Translation
    include ActionView::Helpers::FormOptionsHelper
  end
end
