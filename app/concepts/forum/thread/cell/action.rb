module Forum::Thread::Cell
  class Action < Forum::Cell::Master

    def pin_link
      text = model.pinned == true ? t(:unpin) : t(:pin)
      link_to text, forum_pin_thread_path(model), class: "item", method: :patch
    end

    def lock_link
      text = model.is_locked ? t(:unlock) : t(:lock)
      link_to text, forum_lock_thread_path(model), class: "item", method: :patch
    end

    def edit_link
      link_to t(:edit), forum_edit_thread_path(model), class: "item"
    end
  end
end
