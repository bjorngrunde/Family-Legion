module Forum::Cell
  class Master < Familylegion::Cell::Master

    def roles_options
      [["Every user can access","default"]].concat(Role.all.reverse.map { |role| [role.name.humanize, role.name] unless role.name == "developer"})
    end

    def group_options
      ForumGroup.all.map { |group| [ group.title, group.id]}
    end

    def category_options
      ForumCategory.all.map { |category| [category.title, category.id] }
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
  end
end
