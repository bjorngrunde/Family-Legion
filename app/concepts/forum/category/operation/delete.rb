class Forum::Category::Delete < Trailblazer::Operation

  step Model(ForumCategory, :find_by)
  step Policy::Pundit(ForumPolicy, :delete?)
  step :move_content!
  step :delete_category!

  def move_content!(options, **)
    return unless options["model"].forum_threads.any?

    options["group"] = ForumGroup.find_by(slug: "uncategorized-categories") || ForumGroup.create(title: "Uncategorized Categories", role: "moderator")
    options["category"] = ForumCategory.find_by(slug: "uncategorized-threads") || ForumCategory.create(title: "Uncategorized Threads", role: "moderator", forum_group_id: options["group"].id)

    options["model"].forum_threads.update_all(forum_category_id: options["category"].id, forum_group_id: options["group"].id)
    options["model"].forum_comments.update_all(forum_category_id: options["category"].id, forum_group_id: options["group"].id)
  end

  def delete_category!(options, **)
    options["model"].destroy
  end
end
