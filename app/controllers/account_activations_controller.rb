class AccountActivationsController < ApplicationController

  #ユーザをアクティベーションにする
  def edit
    user = User.find_by(email: params[:email]) #emailからユーザを探し出す
    if user && !user.activated? && user.authenticated?(:activation, params[:id]) #ユーザが存在し、アクティブではなく、トークンが有効な場合
      user.activate #ユーザをアクティブにする
      log_in user #ユーザにログインする
      flash[:success] = "アクティベーションに成功しました"
      redirect_to user #ユーザページに戻す
    else
      flash[:danger] = "アクティベーションに失敗しました"
      redirect_to root_url
    end
  end
end
