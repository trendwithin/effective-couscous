require 'test_helper'
class ScansHelperTest < ActionView::TestCase
  # include ApplicationController
  test 'should return No Result when nil' do
    assert_dom_equal '<h4>No Result</h4>', render_unless_empty([])
  end

  test 'should return list of values' do
    values =['TEST']
    returned = render_unless_empty(values)
    assert_dom_equal %{<li>TEST</li>}, render_unless_empty(values).strip
  end
end
