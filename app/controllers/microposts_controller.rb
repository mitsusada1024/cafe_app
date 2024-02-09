class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy] #create,destroyアクションを踏む前にログインする
  before_action :correct_user,   only: :destroy #破壊する前に正しいユーザかどうか確認

  #投稿するアクション
  def create
    @micropost = current_user.microposts.build(micropost_params) #ユーザの投稿内容の取得
    @micropost.image.attach(params[:micropost][:image]) #投稿された画像を取得する
    if @micropost.save
      flash[:success] = "投稿を行いました！"
      redirect_to root_url #投稿後はrootディレクトリに戻る
    else #失敗したらhomeに戻す
      @feed_items = current_user.feed.paginate(page: params[:page])
      render 'static_pages/home', status: :unprocessable_entity
    end
  end

  #削除するアクション
  def destroy
    @micropost.destroy #削除
    flash[:success] = "投稿を削除しました"
    if request.referrer.nil? || request.referrer == microposts_url
      redirect_to root_url, status: :see_other
    else
      redirect_to request.referrer, status: :see_other
    end
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content, :image)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url, status: :see_other if @micropost.nil?
  end
end
