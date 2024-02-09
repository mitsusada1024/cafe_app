class ApplicationController < ActionController::Base
  include SessionsHelper
  # 渡されたユーザーでログインする

  private

  #ログイン済みがどうかの確認
    def logged_in_user
      unless logged_in? #ログインしていなければ
        store_location #リクエスト先のURLを保存
        flash[:danger] = "ログインが必要です"
        redirect_to login_url , status: :see_other #ログインページに戻す
      end
    end
end
