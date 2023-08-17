require "test_helper"

class ModelCoursesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get model_courses_new_url
    assert_response :success
  end

  test "should get create" do
    get model_courses_create_url
    assert_response :success
  end
end
