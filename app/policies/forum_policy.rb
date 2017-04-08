class ForumPolicy

  def initialize(user, model)
    @user, @model = user, model
  end

  def create?
    @model.id.nil? && @model.creatable_by?(@user)
  end

  def read?
    @model.id && (@user.has_role?(@model.role) || @model.role == "default")
  end

  def update?
    @model.id && @user.has_role?(:moderator)
  end

  def delete?
    @model.id && @user.has_role?(:moderator)
  end
end
