require 'representable/json'

class ForumCategoryRepresenter < Representable::Decorator
  include Representable::JSON

  property :id
  property :title
  property :description
  property :forum_group_id
  property :role

end
