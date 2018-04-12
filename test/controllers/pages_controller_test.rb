require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get frontpage" do
    get pages_frontpage_url
    assert_response :success
  end

end
