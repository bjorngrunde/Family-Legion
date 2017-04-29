require 'representable/json'

class ForumCommentRepresenter < Representable::Decorator
  include Representable::JSON

  property :body
  property :user do
    property :username
    property :profile do
      property :klass
    end
  end
end
