source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Rubyのフレームワーク
gem "rails",           "7.0.4"
# sassのc++実装のgemであり、コンパイルがsass-railsよりも速いと言われているもの　scssより効率的にcssを書くことができる　ネストとかできる
gem "sassc-rails",     "2.1.2"
# アセットファイルにアクセスするためのパスを管理する
gem "sprockets-rails", "3.4.2"
# javascriptモジュールをブラウザに直接インポートする　JSXみたいにコンパイルにステップが必要なものは利用できない
gem "importmap-rails", "1.1.0"
# RailsからTurboを便利に使うための　Turboを使うとJavaScriptを書かずにSPA風のアプリケーションを実現できるようになる
gem "turbo-rails",     "1.1.1"
# DOM操作をさせる　ボタンが押されたときに色を変えたり、ハンバーガーメニューの処理を作ったりできるようになる
gem "stimulus-rails",  "1.0.4"
# JSON形式のデータを簡単に作成する事が出来る　JSON=JavaScript Object NotationでJavaScriptのオブジェクト表記法に由来するデータの記述方式
gem "jbuilder",        "2.11.5"
# Railsのアプリケーションサーバ
gem "puma",            "5.6.4"
# Railsの起動時の処理を最適化することで起動時間を短縮してくれる
gem "bootsnap",        "1.12.0", require: false
# オープンソースで軽量のデータベース管理システム
gem "sqlite3",         "1.4.2"

group :development, :test do
  # ruby用のデバッガ
  gem "debug",   "1.5.0", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  # View内でコンソールを立ち上げて、変数やparameterなどの状態を見る事の出来るデバック用のライブラリ
  gem "web-console", "4.2.0"
end

group :test do
  # webアプリ用のテスティングフレームワーク　RspecやMinitest等も内包している
  gem "capybara",           "3.37.1"
  # プログラムにより、ブラウザを自動操作できるようになる
  gem "selenium-webdriver", "4.2.0"
  # ChromeDriverを簡単に導入してくれる　実際にブラウザでテストがそのように動いているか目視できる
  gem "webdrivers",         "5.0.0"
  # テストに使う　最近はほぼほぼRSpec（Request Spec）が主流だが、Railsチュートリアルがminitest使ってるししゃーない
  gem "rails-controller-testing", "1.0.5"
  # テストに使う
  gem "minitest",                 "5.15.0"
  # テストに使う
  gem "minitest-reporters",       "1.5.0"
  # ファイルが変更された際にそのファイルだけ自動でテストを実行してくれる
  gem "guard",                    "2.18.0"
  # minitestでguardを使うためのgem
  gem "guard-minitest",           "2.4.6"
end

group :production do
  # PostgreSQLというDB（データベース）の接続のために使用する
  gem "pg", "1.3.5"
end

# Windows ではタイムゾーン情報用の tzinfo-data gem を含める必要があります
# gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
