require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  #メインページのテスト
  test "should get main_view" do
    get main_path
    assert_response :success
    assert_select "title", "introduce app"
  end

  #Contactページのテスト
  test "should get contact" do
    get contact_path
    assert_response :success
    assert_select "title", "Contact | introduce app"
  end

  #homeのページのテスト
  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "introduce app"
  end
end
