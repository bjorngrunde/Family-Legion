require 'rails_helper'

RSpec.describe Role, type: :model do
  it "should create several roles for a user" do
    attrs = attributes_for :user
    
    user = User.create(attrs)
    
    user.add_role(:member)
    user.add_role(:moderator)
    user.add_role(:developer)
    
    expect(user.has_role? :developer).to be_true
    expect(user.has_role? :moderator).to be_true
    expect(user.has_role? :member).to be_true
  end
end
