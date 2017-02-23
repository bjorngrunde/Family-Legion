module Session::Cell
  class SignIn < Trailblazer::Cell
    include ActionView::Helpers::TranslationHelper
    include Cell::Translation
  end
end