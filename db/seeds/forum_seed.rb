forum_group = ForumGroup.create({ title: "General", role: "default"})
forum_category = ForumCategory.new({ title: "The Tavern", description: "Have an ale and spill your guts", role: "default"})
forum_category.forum_group = forum_group
forum_category.save

