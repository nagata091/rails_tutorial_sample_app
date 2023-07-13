Rails.application.routes.draw do
  root "static_pages#home"
  # get 'static_pages/home' homeページはrootに設定したので削除
  # 各ページでhelp_pathやhelp_urlが使えるように書き換え
  # get 'static_pages/help'
  get "/help", to: "static_pages#help"
  # get "static_pages/about"
  get "/about", to: "static_pages#about"
  # get "static_pages/contact"
  get "/contact", to: "static_pages#contact"
  get "/signup", to: "users#new"
end
