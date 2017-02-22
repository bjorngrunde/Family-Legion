module User::Cell
	class Show < Trailblazer::Cell
		include ActionView::Helpers::TranslationHelper
    include Cell::Translation
    include ActionView::Helpers::DateHelper
		
		property	:username
		property	:email
		property 	:rank
		property	:phone
		property	:rates
		property	:klass
	
		def full_name
			"#{model.profile.first_name} #{model.profile.last_name}".titleize
		end

		def created_at
			"#{time_ago_in_words(model.created_at)} ago".humanize
		end

		def rank
			"#{model.profile.rank.titleize}"
		end

		def phone
			model.profile.phone
		end

		def klass
			"#{model.profile.klass.humanize}"
		end

	end
end