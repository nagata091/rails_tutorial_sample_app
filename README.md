# Railsチュートリアルでやったことを記述していく。

<details><summary>第1章</summary><div>

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

</div></details>

<details><summary>第2章</summary><div>

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

</div></details>

## 第3章　sample_app 静的なページの作成

<details><summary>サンプルアプリケーションについての説明</summary><div>

# Ruby on Rails チュートリアルのサンプルアプリケーション

これは、次の教材で作られたサンプルアプリケーションです。
[*Ruby on Rails チュートリアル*](https://railstutorial.jp/)
（第7版）
[Michael Hartl](https://www.michaelhartl.com/) 著

## ライセンス

[Ruby on Rails チュートリアル](https://railstutorial.jp/)内にある
ソースコードはMITライセンスとBeerwareライセンスのもとで公開されています。
詳細は [LICENSE.md](LICENSE.md) をご覧ください。

## 使い方

このアプリケーションを動かす場合は、まずはリポジトリを手元にクローンしてください。
その後、次のコマンドで必要になる RubyGems をインストールします。

```
$ gem install bundler -v 2.3.14
$ bundle _2.3.14_ config set --local without 'production'
$ bundle _2.3.14_ install
```

その後、データベースへのマイグレーションを実行します。

```
$ rails db:migrate
```

最後に、テストを実行してうまく動いているかどうか確認してください。

```
$ rails test
```

テストが無事にパスしたら、Railsサーバーを立ち上げる準備が整っているはずです。

```
$ rails server
```

詳しくは、[*Ruby on Rails チュートリアル*](https://railstutorial.jp/)
を参考にしてください。


</div></details>

・sample_appを新しく作成

・--skip-bundleによってjavascriptを使うためのパッケージのインストールもスキップしているらしい　あとで手動で入れるよ

・gemfileを書き換え、bundleインストール

・このとき、production環境でしか使わないgemはインストールしないように設定することで、
developmentとtest環境ではSQLite、production環境ではpostgreSQLを使うようになる。この時点ではpostgreSQLはまだ未インストール

・gtihubにリポジトリrails-tutorial-secondを作成してpush

・第1章でもしたように、helloメソッドを定義、rootを設定、config/environment/development.rbに接続許可を設定

・gemfileをロックし、ここまでをpush

・rails g でコントローラ名「Static Pages」でHome、Helpページを作成

・新しいブランチstatic-pagesを作成し、そこにpush　$ git push --set-upstream origin static-pages　としないとできなかった

・コントローラー作成をミスってもとに戻したいときは、$ rails destroy ~~~~　とすればOK

・HomeページとHelpページをいろいろ修正

・Aboutページを手動で作るに当たって、まずはテストを作成する

・テストをパスするためにルーティング、コントローラーのメソッド、ビューを作成

・各ページにページタイトルを表示させる作業をしていく

・まずテストを作成　assert_select "title, "タイトル"

・テストの最初にsetupメソッドを定義して重複を回避

・application.html.erbファイルのタイトル、各ページにprovideメソッドを設定することでタイトルが動的に切り替わるように

・演習：ルートを変更したことでroot_urlが利用できるようになった。これに対するテストを作成

・ここまでを"Static Pages作成終了"とcommitしてpush
