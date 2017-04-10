module Forum::Cell
  class Master < Familylegion::Cell::Master

    def roles_options
      [["Every user can access","default"]].concat(Role.all.reverse.map { |role| [role.name.humanize, role.name] unless role.name == "developer"})
    end

    def group_options
      ForumGroup.all.map { |group| [ group.title, group.id] unless group.slug == "uncategorized-categories"}
    end

    def category_options
      ForumCategory.all.map { |category| [category.title, category.id] unless category.slug == "uncategorized-threads"}
    end

    def user_can_access?
      return true if current_user.has_role?(model.role) || model.role == "default"
      false
    end

    def portrait
      image_tag(model.user.profile.thumbnail, class: "ui circular image")
    end

    def post_counter user
      user.forum_threads.count + user.forum_comments.count
    end

    def is_owner? user
      model.user.id == user.id
    end

   def reply_link
    category = model.forum_category.slug
    group = model.forum_group.slug
    thread = model.is_a?(ForumThread) ? model.slug : model.forum_thread.slug

    link_to "<i class='reply icon'></i> #{t(:reply)}", forum_new_comment_path(group: group, category: category, thread: thread), class: "ui tiny alliance button", data: { tooltip: t(:respond_with_comment), position: "top center"}
    end

    def subscription_link
      link_to "<i class='bookmark icon'></i> #{t(:subscribe)}", "#", class: "ui tiny alliance button"
    end

    def quote_link
      link_to "<i class='quote left icon'></i> #{t(:quote)}", "#", class: "ui tiny alliance button", data: { tooltip: t(:quote_this_comment), position: "top center"}
    end
  end
end
