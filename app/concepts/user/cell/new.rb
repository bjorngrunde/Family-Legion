module User::Cell
  class New < Trailblazer::Cell
    include ActionView::Helpers::TranslationHelper
    include Cell::Translation
    include ActionView::Helpers::FormOptionsHelper
  end
end