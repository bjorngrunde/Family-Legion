module GuildApplication::Cell
  class Table < Trailblazer::Cell
    include ActionView::Helpers::TranslationHelper
    include Cell::Translation
  end
end
