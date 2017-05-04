class EventPolicy
  def initialize(user, model)
    @user, @model = user, model
  end

  def update?
    @model.id && (@model.user == @user || @user.has_role(:admin))
  end
end