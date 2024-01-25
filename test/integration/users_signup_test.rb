require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest

  #無効なサインアップ情報のテスト
  test "invalid signup information" do
    get signup_path #signup_pathにgetリクエストを送り、pageにアクセス
    assert_no_difference 'User.count' do #無効なユザー情報を送り、ユーザ情報が増えていないことの確認
      post users_path, params: { user: { name:  "",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    assert_response :unprocessable_entity #レスポンスがunprocessable_entityであることの確認
    assert_template 'users/new' #失敗した後、ユーザ登録pageが再度表示されていることの確認
  end

  #有効なサインアップのテスト
  test "valid signup information" do
    assert_difference 'User.count', 1 do #有効なユーザ情報をpostリクエストで送信した結果一つ増えていることの確認
      post users_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    follow_redirect! #ログイン成功後ページが移動することの確認
    assert_template 'users/show' #移動後のページ
  end


end
