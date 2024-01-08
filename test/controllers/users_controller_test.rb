require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get createacount_path
    assert_response :success
    assert_select "title", "create_account | introduce app"
  end

end
