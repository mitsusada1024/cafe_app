module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  # 現在ログイン中のユーザーを返す（いる場合）
  def current_user
    if session[:user_id] #すでにユーザがログインしているかどうか
      @current_user ||= User.find_by(id: session[:user_id]) #idを元にユーザ情報を返す、すでに値が入ってたらスルー
    end
  end

  # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !current_user.nil?
  end

  # 現在のユーザーをログアウトする
  def log_out
    reset_session
    @current_user = nil # 安全のため
  end
end
