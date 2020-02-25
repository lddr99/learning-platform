require 'test_helper'

class ManagementControllerTest < ActionDispatch::IntegrationTest
  test "should get edit_course" do
    get management_edit_course_url
    assert_response :success
  end

end
