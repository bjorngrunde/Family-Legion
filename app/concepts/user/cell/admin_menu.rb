module User::Cell
  class AdminMenu < Trailblazer::Cell
    include ActionView::Helpers::TranslationHelper
    include Cell::Translation
    
    def edit_button
      link_to("<i class='edit icon'></i> #{t(:edit)}",  edit_admin_user_path(model), class: "tiny ui icon inverted button", data: { :tooltip => t(:edit_user), :position =>"bottom center"}).html_safe
    end

  end
end