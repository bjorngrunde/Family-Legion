class AdminPolicy
  def initialize(user, model)
    @user, @model = user, model
  end

  def create?
    @model.id.nil? && @user.has_role?(:admin)
  end

  def update?
    @model.id && @user.has_role?(:admin)
  end

  def delete?
    @model.id && @user.has_role?(:admin) && !@model.is_a?(User)
  end
end
