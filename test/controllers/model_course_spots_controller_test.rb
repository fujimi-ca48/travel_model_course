require "test_helper"

class ModelCourseSpotsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get model_course_spots_new_url
    assert_response :success
  end

  test "should get create" do
    get model_course_spots_create_url
    assert_response :success
  end
end
