class AdminPolicy
  def initialize(user, model)
    @user, @model = user, model
  end

  def create?
    @model.id.nil? && @user.has_role?(:admin)
  end
end
