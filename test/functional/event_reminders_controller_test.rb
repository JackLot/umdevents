require 'test_helper'

class EventRemindersControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

end
