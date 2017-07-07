require 'representable/json'

class CommentRepresenter < Representable::Decorator
  include Representable::JSON

  property :id
  property :body
  property :created_at
  property :user do

    property :username, getter: -> (represented:, **) { represented.username.humanize }

    property :profile do

      property :thumbnail
      property :klass, getter: -> (represented:, **) { represented.klass.sub("_", "-") }
    end
  end

  collection_representer class: Comment
end
