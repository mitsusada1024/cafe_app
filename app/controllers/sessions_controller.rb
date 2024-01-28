class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase) #mailアドレスの情報からデータベースを検索downcaseは大文字を小文字に
    if user && user.authenticate(params[:session][:password]) #データベースにユーザがいるかパスワードがただしいか
      reset_session #session情報のリセット
      log_in user #ユーザをログイン状態にする
      redirect_to user #ユーザの情報にログインする
    else
      flash.now[:danger] = 'Invalid email/password combination' #フラッシュメッセージの表示 nowだから出たら消える
      render 'new', status: :unprocessable_entity #ログインページの再表示
    end
  end

  def destroy
    log_out
    redirect_to root_url, status: :see_other
  end

end
