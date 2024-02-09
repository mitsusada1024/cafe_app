class SessionsController < ApplicationController
  def new #newアクション
  end

  #ログイン処理
  def create
    user = User.find_by(email: params[:session][:email].downcase) #打ち込んだemailをデータベースから探す
    if user && user.authenticate(params[:session][:password])#探してきたユーザとデータベース内のパスワードと等しいかどうかの確認
      if user.activated? #ユーザがアクティブかどうかの確認
        forwarding_url = session[:forwarding_url]  #ユーザーがログインする前にアクセスしようとしていたURLを取得
        reset_session #セッションのリセット
        params[:session][:remember_me] == '1' ? remember(user) : forget(user) #remember me woを押していたら記憶、押していなければ忘れる
        log_in user
        redirect_to forwarding_url || user
      else #アクティブではなかった時の場合
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message #警告メッセージを送る
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new', status: :unprocessable_entity
    end
  end

  #ログアウト処理
  def destroy
    log_out if logged_in? #ログインしていればログアウト
    redirect_to root_url, status: :see_other #ログアウト後はルートに戻る
  end

end
