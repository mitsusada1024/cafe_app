class ApplicationController < ActionController::Base
  include SessionsHelper
  # 渡されたユーザーでログインする

  private

  #ログイン済みがどうかの確認
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in"
        redirect_to login_url , status: :see_other
      end
    end
end
