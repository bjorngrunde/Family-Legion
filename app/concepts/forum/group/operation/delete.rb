class Forum::Group::Delete < Trailblazer::Operation

  step Model(ForumGroup, :find_by)
  step Policy::Pundit(ForumPolicy, :delete?)
  step :move_content!
  step :delete_group!

  def move_content!(options, **)
    return unless options["model"].forum_categories.any?

    options["group"] = ForumGroup.find_by(slug: "uncategorized-categories") || ForumGroup.create(title: "Uncategorized Categories", role: "moderator")

    options["model"].forum_categories.update_all(forum_group_id: options["group"].id)
    options["model"].forum_threads.update_all(forum_group_id: options["group"].id)
    #options["model"].forum_comments.update_all(forum_group_id: options["group"].id)
  end

  def delete_group!(options, **)
    options["model"].destroy
  end
end
