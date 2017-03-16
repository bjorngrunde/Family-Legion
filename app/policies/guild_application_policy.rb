class GuildApplicationPolicy

  def initialize(user, model)
    @user, @model = user, model
  end

  def list?
    @model.readable_by?(@user)
  end
end