class StaticPagesController < ApplicationController
  def home
    #ログインしている時だけ踏める
    # ユーザのマイクロポストを取得
    if logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  #contactアクション
  def contact
  end

  #main_viewアクション
  def main_view
  end
end
