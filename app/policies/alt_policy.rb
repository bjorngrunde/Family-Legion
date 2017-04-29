class AltPolicy

  def initialize(user, model)
    @user, @model = user, model
  end

  def create?
    @model.id.nil?
  end

  def update?
    (@model.id && @model.user == @user) || @model.updatable_by?(@user)
  end

  def delete?
    (@model.id && @model.user_id == @user.id) || @model.deletable_by?(@user)
  end
end
