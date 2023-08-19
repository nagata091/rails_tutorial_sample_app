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

<details><summary>第3章</summary><div>

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

</div></details>

<details><summary>第5章</summary><div>

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

</div></details>

<details><summary>第6章</summary><div>

## 第 6 章　ユーザーのモデルを作成する

・ここから第12章まで、ユーザー認証システムを構築していく

・トピックブランチを作成 `$ git switch -c modeling-users`

・簡単に消えることのないユーザーモデルを構築する

・`$ rails g model User name:string email:string`でUserモデルを生成、マイグレーション

・ユーザーの検証のため、存在性（presence）、長さ（length）、フォーマット（format）、一意性（uniqueness）の検証をする

・name属性とemail属性の存在性のテストとバリデーションを作成

・name属性とemail属性の長さのテストとバリデーションを作成

・email属性のフォーマットのテストとバリデーションを作成

・email属性の一意性のテストとバリデーションを作成

・データベースレベルの一意性を保証するために、emailインデックスをマイグレーションに追加する `$ rails g migration add_index_to_users_email`

・生成されたマイグレーションファイルに次を追記 `add_index :users, :email, unique: true`

・`test/fixtures/users.yml` の中身をいったん削除するとテストがパスするようになる

・コールバックメソッドを定義し、データベースでも一意性を保証するようにする。`before_save {self.email = email.downcase}`を`models/user.rb`に追記

・ここまでをコミットしてpush

・PR のテスト

・セキュアなパスワードを追加する

・セキュアなパスワードを実装するには`has_secure_password`をユーザーモデルに追記すればよい

・`has_secure_password`を追記することによって、さまざまな機能が使えるようになる

・機能を使うために、Userモデルに`password_digest`カラムを作成する

・`$ rails g migration add_password_digest_to_users password_digest:string`でマイグレーションファイルを作成

・`$ rails db:migrate`でマイグレーションを適用

・`Gemfile`に`gem "bcrypt", "3.1.18"`を追記して`$ bundle _2.3.14_ install`コマンドでインストール

・`models/users.rb`に`has_secure_password`を追記

・`has_secure_password`を追記したことによって、password属性とpassword_confirmation属性に対してのバリデーションが強制的に追加されたため、テストを書き換える。

・テストを元にバリデーションを追加

・Railsコンソールで新規ユーザーを作成`User.create(name: "Michael Hartl", email: "michael@example.com", password: "foobar", password_confirmation: "foobar")`

・作成したユーザーに対して`user.authenticate("foobar")`とするとパスワードが正しいのでtrueとなり、ユーザー情報を返す。パスワードが間違っていればfalseを返す

・`!!user.authenticate("foobar")`とするとtrueを返す

・ここまでをpush

</div></details>

<details><summary>第7章</summary><div>

## 第 7 章　ユーザー登録

・`$ git switch -c sign-up`で新しいブランチを作成

・サイトのレイアウトにデバッグ情報を追加

・ルートファイルに`resources :users`を追加。これによりusersに対する各アクション、名前付きルーティングが利用できるようになる

・`show.html.erb`を作成し、usersコントローラーにshowアクションを作成。@user変数にパラメーターのIDのユーザー情報を入れるようにした

・debuggerメソッドを任意の部分に差し込むことにより、メソッドがある時点での確変の状態を確認することができる

・Gravatarを使ってプロフィール画像を設定する

・ユーザー情報を次に変更`user.update(name: "Example User", email: "example@railstutorial.org", password: "foobar", password_confirmation: "foobar")`

・ユーザーのサイドバーを実装する

・ユーザー登録ページを実装していく

・ユーザーコントローラーにcreateメソッドを定義

・脆弱性に対処するため、Strong Parametersというテクニックを使用する

・コントローラ内部で`user_params`を定義し、許可するデータと許可しないデータを分けるようにした

・新規登録ページで、入力内容に誤りがあるときにエラーメッセージを表示させるようにした

・エラーメッセージは`shared/_errormessages.html.erb`ファイルに記述し、renderメソッドで表示させる

・エラーメッセージを日本語化。`https://blog.cloud-acct.com/posts/u-rails-error-messages-jayml/`を参考

・フォームに対するテストをつくる。インテグレーションテストを新しく作成

・登録フォームを完成させる

・フラッシュメーッセージを表示させるためのコードをapplication.html.erbに追記

・入力内容が無効、有効それぞれの場合のテストを作成

・ここまでをpush

</div></details>

<details><summary>第8章</summary><div>

## 第 8 章　ユーザー登録

・ログイン機能を作るトピックブランチを作成 `basic-login`

・Sessionsコントローラを作成`$ rails g controller Sessions new`

・ログイン画面を作成

・フォームへの入力が無効な場合の処理を作成、フラッシュメッセージのテストを作成
　`flash.now`を使うとページが切り替わったときに非表示になる。

・ログイン中の状態での有効な値の送信をフォームで正しく扱えるようにする。

・sessionsヘルパーにログイン機能つくり、createに実装。ユーザーIDを暗号化cookieとして安全に置けるようになった。

・ユーザーIDを別のページで取り出せるようにする。current_userメソッドを作る。
　これにより、ユーザーがログインしているかに応じてアプリケーションの動作を変更できるようになった。

・レイアウトのリンクを追加する。リンクはログイン状態に応じて変わるようにする。

・`logged_in?`メソッドをつくる。

・`_header.html.erb`を書き換える。

・ここまでをコミット

・メニューのドロップダウンリストをjavascriptでつくる

・モバイル向けスタイリングを作成する

・レイアウトの変更をテストする

・ユーザー登録時にログインするようにする

・ログアウト機能をつくる

・それぞれのテストを作成

・第8章終了。ここまでをpush

</div></details>

<details><summary>第9章</summary><div>

## 第 9 章
