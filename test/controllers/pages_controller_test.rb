require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get frontpage as root" do
    get root_url
    assert_response :success
  end

end
