require 'test_helper'

class FamilylegionConceptTest < Cell::TestCase
  test "show" do
    html = concept("familylegion/cell").(:show)
    assert html.match /<p>/
  end


end
