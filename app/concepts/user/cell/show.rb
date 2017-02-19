module User::Cell
	class Show < Trailblazer::Cell
		include ActionView::Helpers::TranslationHelper
    include Cell::Translation
    include ActionView::Helpers::DateHelper
		
		def full_name
			"#{model.profile.first_name} #{model.profile.last_name}".titleize
		end
	end
end