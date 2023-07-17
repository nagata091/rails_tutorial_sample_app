# Rails チュートリアルでやったことを記述していく。

<details><summary>第1章</summary><div>

## 第 1 章　 hello_app

・クラウド IDE で環境構築

・rvm を使って`ruby3.1.2`をインストール

`$ rvm get stable`

`$ rvm install 3.1.2`

`$ rvm --default use 3.1.2`

・rails をインストールする

ruby ドキュメントをスキップする設定を`.gemrcファイル`に追加

`$ echo "gem: --no-document" >> ~/.gemrc`

`rails7.0.4`をインストール

`$ gem install rails -v 7.0.4`

・`bundler2.3.14`をインストール

`$ gem install bundler -v 2.3.14`

・cloud9 環境のディスク容量を追加する

`$ source <(curl -sL https://cdn.learnenough.com/resize)``

・`~/environment`で`hello_app`という名前の rails アプリを新規作成

バージョンを指定　`--skip-bundle`コマンドを省略すると、システム上で見つかる最も直近のバージョンの bundler が使われることになる

`$ rails _ 7.0.4 _ new hello_app --skip-bundle`

・Gemfile の中身を書き換え

・`config/environment/development.rb`にクラウド IDE から rails サーバーへ接続する許可を記述

`config.hosts.clear`

・rails サーバーを起動、初期画面が表示されることを確認

・MVC(model-view-controller)

ブラウザからのリクエストを controller が受け取り、model(データベースとの通信を担当)を対話して呼び出し、view をレンダリングして HTML をブラウザに返す

・`application_controller`に hello メソッドを定義

・`config/routes`で hello メソッドで表示される HTML を root に設定

・`localhost:3000`で hello メソッドで定義した HTML が表示されることを確認

・クラウド IDE の git バージョンが 2.17.1 であったのでアップグレード　 2.41.0 に

`$ source <(curl -sL https://cdn.learnenough.com/upgrade_git)``

### ・github にリポジトリ hello_app-second を作成してプッシュ

↓ 個人アクセストークン

```
　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
```

</div></details>

<details><summary>第2章</summary><div>

## 第 2 章　 toy_app

・`rails new` で`toy_app`を作成

・gemfile を書き換えて`bundle install`第 1 章で作ったものに加え、"sassc-rails"をインストール

・第 1 章でもしたように、hello メソッドを定義、root を設定、`config/environment/development.rb`に接続許可を設定

・rails サーバーを起動し、無事起動することを確認

### ・gtihub のリポジトリ toy\_ app_second を作成して push

・scaffold コマンドで Users モデルを作成　カラムは`name:string`と`email:string`

・作ったデータベースをマイグレート

・scaffold で作成したので、URL が~/users に新しくページが自動で作成されていることを確認

・root ページを`users/index`に変更

・scaffold はいろんなページを一気に作成してくれるので便利だが、データの検証やテストが行われていないなどの問題点が多々ある。

・Micropost モデルを作成　カラムは`content:text`と`user_id:integer`

・`models/micropost.rb`に投稿のバリデーションを作成　投稿を 140 字に制限

・`models/user.rb`に user 一人に複数の micropost が紐づくように設定　`has_many :microposts`

・`models/micropost.rb`に micropost 一つに user 一人が紐づくように設定　`belongs_to :user`

・rails コンドールで紐づけがちゃんとできているか確認

・演習：ユーザーの show ページに、ユーザーの最初の投稿を表示させる

・演習：投稿のバリデーションを追加　空白だとエラーを返すように

・演習：User モデルにバリデーションを追加　 name と email が空白のときにエラーを返す

・ユーザーと投稿のページの行ったり来たりが面倒だったのでヘッダーに各一覧へのリンクを設置

### ・toy_app の作成終了　 push

</div></details>

## 第 3 章　 sample_app 静的なページの作成

<details><summary>サンプルアプリケーションについての説明</summary><div>

# Ruby on Rails チュートリアルのサンプルアプリケーション

これは、次の教材で作られたサンプルアプリケーションです。
[_Ruby on Rails チュートリアル_](https://railstutorial.jp/)
（第 7 版）
[Michael Hartl](https://www.michaelhartl.com/) 著

## ライセンス

[Ruby on Rails チュートリアル](https://railstutorial.jp/)内にある
ソースコードは MIT ライセンスと Beerware ライセンスのもとで公開されています。
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

テストが無事にパスしたら、Rails サーバーを立ち上げる準備が整っているはずです。

```
$ rails server
```

詳しくは、[_Ruby on Rails チュートリアル_](https://railstutorial.jp/)
を参考にしてください。

</div></details>

・sample_app を新しく作成

・`--skip-bundle`によって javascript を使うためのパッケージのインストールもスキップしているらしい　あとで手動で入れるよ

・gemfile を書き換え、bundle インストール

・このとき、production 環境でしか使わない gem はインストールしないように設定することで、
development と test 環境では SQLite、production 環境では postgreSQL を使うようになる。この時点では postgreSQL はまだ未インストール

・gtihub にリポジトリ rails-tutorial-second を作成して push

・第 1 章でもしたように、hello メソッドを定義、root を設定、`config/environment/development.rb`に接続許可を設定

・gemfile をロックし、ここまでを push

・rails g でコントローラ名「Static Pages」で Home、Help ページを作成

・新しいブランチ static-pages を作成し、そこに push 　`$ git push --set-upstream origin static-pages`としないとできなかった

・コントローラー作成をミスってもとに戻したいときは、`$ rails destroy ~~~~`とすれば OK

・Home ページと Help ページをいろいろ修正

・About ページを手動で作るに当たって、まずはテストを作成する

・テストをパスするためにルーティング、コントローラーのメソッド、ビューを作成

・各ページにページタイトルを表示させる作業をしていく

・まずテストを作成`assert_select "title, "タイトル"``

・テストの最初に setup メソッドを定義して重複を回避

・`application.html.erbファイル`のタイトル、各ページに provide メソッドを設定することでタイトルが動的に切り替わるように

・演習：ルートを変更したことで root_url が利用できるようになった。これに対するテストを作成

・ここまでを"Static Pages 作成終了"と commit して main ブランチに merge し、push

・minitest reporters を導入

・Guard によるテストの自動化を導入　ターミナルで `$ bundle _2.3.14_ exec guard init` を実行

・生成された Guard ファイルを編集　編集後は新しいターミナルで `$ bundle _2.3.14_ exec guard` を実行しておけば自動でテストしてくれる

・ここまでを"テストのセットアップ完了"で commit して push

・第 4 章で application_helper にタイトルを表示するヘルパーメソッドを追加

・ヘルパーメソッドを追加したことを push

## 第 5 章　レイアウトを作成する

・git branch を作成　`filling-in-layout`

・ヘッダー、home の html を編集

・bootstrap をインストールする

・すべての CSS を一つにまとめるため、カスタム CSS ファイルを作成

・フッターの html を編集

・ヘッダーとフッターの CSS を追加

・コンタクトページを追加

・各ページの名前付きルーティングを定義　テストを名前付きルーティングに書き換え

・結合テスト(integration_test)を作成 `$ rails g integration-test site-layout`

・ここまでを push

・static_pages の各ページの文章を修正

・Application ヘルパーで使っている full_title メソッドのテストを作成

・ここまでを commit

・ユーザー登録ページへのルーティングを作成していく

・Users コントローラーを作成、new を Sign up ページとして作成

・ここまでを push

・PR のテスト
