#パスワード再発行用
class PasswordResetsController < ApplicationController
  before_action :get_user,         only: [:edit, :update] #edit,updateのアクションに触れる前に、トークンの期限切れがないか確認
  before_action :valid_user,       only: [:edit, :update] #edit,updateのアクションに触れる前に、有効なユーザかどうか確認
  before_action :check_expiration, only: [:edit, :update] #edit,updateのアクションに触れる前に、トークンの期限切れがないか確認

  #newアクション
  def new
  end

  #createアクション
  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase) #データベースからメールアドレスと等しいユーザを探す
    if @user#ユーザが見つかればリセット用のmeailを送る
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "Email sent with password reset instructions"
      redirect_to root_url
    else #ユーザがいなければ警告メッセージを流す
      flash.now[:danger] = "Email address not found"
      render 'new', status: :unprocessable_entity
    end
  end

  #editアクション
  def edit
  end

  #upadateアクション
  def update
    if params[:user][:password].empty? #もしパスワードが空なら
      @user.errors.add(:password, "can't be empty")
      render 'edit', status: :unprocessable_entity
    elsif @user.update(user_params) #更新した時
      reset_session # セッションのリセット
      log_in @user #更新後にログイン
      flash[:success] = "Password has been reset." #メッセージを表示
      redirect_to @user #ユーザページに帰ってくる
    else #更新に失敗
      render 'edit', status: :unprocessable_entity      # （2）への対応
    end
  end

  private

  #permit部分
  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  # beforeフィルタ

  #emailアドレスからデータベースからユーザを取得
  def get_user
    @user = User.find_by(email: params[:email])
  end

  # ユーザが存在し、アクティブであることの確認かつレセットトークンが有効であることの確認
  # 通らなければrootに戻す
  def valid_user
    unless (@user && @user.activated? && @user.authenticated?(:reset, params[:id]))
      redirect_to root_url
    end
  end

  # トークンが期限切れかどうか確認して、切れてたらメッセージを表示してリセット画面に戻す
  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = "Password reset has expired."
      redirect_to new_password_reset_url
    end
  end
end
