class UserPolicy

  def initialize(user, model)
    @user, @model = user, model
  end

  def create?
    @model.id.nil? && @model.creatable_by?(@user)
  end

  def update?
    @model.id && @model.updatable_by?(@user)
  end

  def delete?
    @model.id && @model.deletable_by?(@user)
  end
  
  def editable?
    return false unless @model.id
    return false if @model.has_role?(:developer) && !@user.has_role?(:developer)
    return false unless @model.updatable_by?(@user)
    true
  end
end
