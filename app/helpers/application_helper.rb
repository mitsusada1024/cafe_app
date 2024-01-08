module ApplicationHelper
  #ページごとにタイトルを返す
  def full_title(page_title = '')#引数を渡さなければpage_titleは空にする
    base_title = "introduce app"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end
end
