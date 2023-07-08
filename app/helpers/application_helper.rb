module ApplicationHelper

  # 各ページタイトルを表示するヘルパーメソッド
  def full_titel(page_title = "")
    base_title = "サンプルアプリ"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end
end
