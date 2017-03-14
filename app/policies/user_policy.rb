class UserPolicy
  
  def initialize(user, model)
    @user, @model = user, model
  end

  def create?
    @model.id.nil? && @model.creatable_by?(@user)
  end
end