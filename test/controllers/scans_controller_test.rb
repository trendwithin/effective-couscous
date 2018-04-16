require 'test_helper'

class ScansControllerTest < ActionDispatch::IntegrationTest
  test "should get demo" do
    get scans_demo_url
    assert_response :success
  end

end
