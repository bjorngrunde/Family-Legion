module Forum::Comment::Cell
  class Action < Forum::Cell::Master

    def delete_link
      link_to "<i class='trash icon forum action'></i>", forum_delete_comment_path(model), class: "item", method: :delete, data: { tooltip: "#{t(:delete_comment)}" }
    end
  end
end
