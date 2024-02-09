class RelationshipsController < ApplicationController
  before_action :logged_in_user#ログインしてないのこのしたのアクションは踏めない

  #ユーザフォロー
  def create
    @user = User.find(params[:followed_id])#フォローするユーザを探す
    current_user.follow(@user)#現在のユーザがフォローしたいユーザをフォロー
    respond_to do |format|
      format.html { redirect_to @user }
      format.turbo_stream
    end
  end

  #ユーザのフォローを外す
  def destroy
    @user = Relationship.find(params[:id]).followed#フォロー中の中から、消したいやつを探す
    current_user.unfollow(@user)#現在のユーザが探してきた消したいやつのフォローを外す
    respond_to do |format|
      format.html { redirect_to @user, status: :see_other }
      format.turbo_stream
    end
  end
end
