class UserPolicy
  
  def initialize(user, model)
    @user, @model = user, model
  end

  def settings?
    return @user.id == @model.user_id unless @model.is_a?(User)
    @user.id == @model.id
  end
end