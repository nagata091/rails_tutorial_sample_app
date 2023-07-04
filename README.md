# Railsチュートリアルでやったことを記述していく。

<detais>
<summary>第1章と第2章</summary>

## 第1章　hello_app
・クラウドIDEで環境構築

・rvmを使ってruby3.1.2をインストール

　$ rvm get stable

　$ rvm install 3.1.2

　$ rvm --default use 3.1.2

・railsをインストールする

　rubyドキュメントをスキップする設定を.gemrcファイルに追加

　$ echo "gem: --no-document" >> ~/.gemrc

　rails7.0.4をインストール

　$ gem install rails -v 7.0.4

・bundler2.3.14をインストール

　$ gem install bundler -v 2.3.14

・cloud9環境のディスク容量を追加する

　$ source <(curl -sL https://cdn.learnenough.com/resize)

・~/environmentでhello_appという名前のrailsアプリを新規作成

　バージョンを指定　--skip-bundleコマンドを省略すると、システム上で見つかる最も直近のバージョンのbundlerが使われることになる

　$ rails _ 7.0.4 _ new hello_app --skip-bundle

・Gemfileの中身を書き換え

・config/environment/development.rbにクラウドIDEからrailsサーバーへ接続する許可を記述

　config.hosts.clear

・railsサーバーを起動、初期画面が表示されることを確認

・MVC(model-view-controller)

　ブラウザからのリクエストをcontrollerが受け取り、model(データベースとの通信を担当)を対話して呼び出し、viewをレンダリングしてHTMLをブラウザに返す

・application_controllerにhelloメソッドを定義

・config/routesでhelloメソッドで表示されるHTMLをrootに設定

・localhost:3000でhelloメソッドで定義したHTMLが表示されることを確認

・クラウドIDEのgitバージョンが2.17.1であったのでアップグレード　2.41.0に

　$ source <(curl -sL https://cdn.learnenough.com/upgrade_git)

### ・githubにリポジトリhello_app-secondを作成してプッシュ

　↓個人アクセストークン

　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


## 第2章　toy_app

・rails new で toy_app を作成

・gemfileを書き換えて bundle install　第1章で作ったものに加え、"sassc-rails"をインストール

・第1章でもしたように、helloメソッドを定義、rootを設定、config/environment/development.rbに接続許可を設定

・railsサーバーを起動し、無事起動することを確認

### ・gtihubのリポジトリtoy_ app_secondを作成してpush

・scaffoldコマンドでUsersモデルを作成　カラムはname:stringとemail:string

・作ったデータベースをマイグレート

・scaffoldで作成したので、URLが~/usersに新しくページが自動で作成されていることを確認

・rootページをusers/indexに変更

・scaffoldはいろんなページを一気に作成してくれるので便利だが、データの検証やテストが行われていないなどの問題点が多々ある。

・Micropostモデルを作成　カラムはcontent:textとuser_id:integer

・models/micropost.rb に投稿のバリデーションを作成　投稿を140字に制限

・models/user.rb にuser一人に複数のmicropostが紐づくように設定　has_many :microposts

・models/micropost.rb にmicropost一つにuser一人が紐づくように設定　belongs_to :user

・railsコンドールで紐づけがちゃんとできているか確認

・演習：ユーザーのshowページに、ユーザーの最初の投稿を表示させる

・演習：投稿のバリデーションを追加　空白だとエラーを返すように

・演習：Userモデルにバリデーションを追加　nameとemailが空白のときにエラーを返す

・ユーザーと投稿のページの行ったり来たりが面倒だったのでヘッダーに各一覧へのリンクを設置

### ・toy_appの作成終了　push

</details>

## 第3章　sample_app 静的なページの作成

・sample_appを新しく作成

・--skip-bundleによってjavascriptを使うためのパッケージのインストールもスキップしているらしい　あとで手動で入れるよ

・gemfileを書き換え、bundleインストール

・このとき、production環境でしか使わないgemはインストールしないように設定することで、
developmentとtest環境ではSQLite、production環境ではpostgreSQLを使うようになる。この時点ではpostgreSQLはまだ未インストール

・gtihubにリポジトリrails-tutorial-secondを作成してpush
