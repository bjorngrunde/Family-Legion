class EventPolicy
  def initialize(user, model)
    @user, @model = user, model
  end

  def update?
    @model.id && (@model.user == @user || @user.has_role?(:admin))
  end

  def read?
    return true if @model.id && (@model.public || @model.guild_event)
    return true if @model.id && !@model.public && !@model.guild_event && (@model.user == @user || @model.invites.find_by(user_id: @user.id))
    false
  end
end
