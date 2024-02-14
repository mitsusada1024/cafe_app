class UsersController < ApplicationController
  #index, :edit, :update, :destroy,:following, :followersのアクションを実行する前に
  # logged_in_userでログインしているか確認
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
  :following, :followers]
  #:edit, :updateのアクションを実行する前に正しいユーザか確認
  before_action :correct_user,   only: [:edit, :update]
  #destroyアクションを実行する前に管理者かどうか確認
  before_action :admin_user,     only: :destroy

  #ユーザを全部表示（ページ機能付きkaminariに変えたい）
  def index
    @users = User.page(params[:page])
  end

  #特定のユーザを取得、マイクロポストも取得
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.page(params[:page])
  end

  #ユーザを削除して、削除成功のメッセージを表示、削除後は、users_urlへ移動
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "ユーザ情報を削除しました"
    redirect_to users_url, status: :see_other
  end

  def new
    @user = User.new
  end

  #ユーザの新規作成
  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new', status: :unprocessable_entity
    end
  end

  #編集するために編集するユーザを探す
  def edit
    @user = User.find(params[:id])
  end

  #ユーザの更新　指定したユーザを探してきて、レコードを更新
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  #ユーザがフォローしている人たちを探す
  def following
    @title = "フォロー中のリスト"
    @user  = User.find(params[:id])
    @users = @user.following.page(params[:page])
    render 'show_follow'
  end

  #ユーザのフォワーを探す
  def followers
    @title = "フォロワーのリスト"
    @user  = User.find(params[:id])
    @users = @user.followers.page(params[:page])
    render 'show_follow'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  #正しいユーザかどうか確認、そのユーザが現在ログインしているユーザかどうか確認
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url, status: :see_other) unless current_user?(@user)
  end

  # 管理者かどうか確認、現在のユーザが管理者権限を持っているかどうか確認
  def admin_user
    redirect_to(root_url, status: :see_other) unless current_user.admin?
  end
end
