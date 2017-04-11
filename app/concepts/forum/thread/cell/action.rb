module Forum::Thread::Cell
  class Action < Forum::Cell::Master

    def pin_link
      text = model.pinned == true ? t(:unpin) : t(:pin)
      link_to text, forum_pin_thread_path(model), class: "item", method: :patch
    end
  end
end
