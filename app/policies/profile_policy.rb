class ProfilePolicy

  def initialize(user, model)
    @user, @model = user, model
  end

  def update?
    (@model.id && @model.user_id == @user.id) || @model.updatable_by?(@user)
  end
end