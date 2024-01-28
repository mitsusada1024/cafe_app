require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:kouki)
  end

  test "login with valid email/invalid password" do
    get login_path #/loginにgetを送り、pageを取得
    assert_template 'sessions/new' #現在のpageが'sessions/new'かどうか確認
    post login_path, params: { session: { email:    @user.email,
                                          password: "invalid" } }
    assert_not is_logged_in?
    assert_response :unprocessable_entity #無効が帰ってくることの確認
    assert_template 'sessions/new' #無効が帰っきたあと'sessions/new'が表示されていることの確認
    assert_not flash.empty? #フラッシュメッセージが空ではない事の確認(表示されているかどうかの確認)
    get root_path #homeページに戻る
    assert flash.empty? #フラッシュメッセージが消えていることの確認
  end

  test "login with valid information followed by logout" do
    post login_path, params: { session: { email:    @user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    delete logout_path
    assert_not is_logged_in?
    assert_response :see_other
    assert_redirected_to root_url
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end
end
