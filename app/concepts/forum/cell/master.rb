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
  end
end
