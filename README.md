# Railsチュートリアルでやったことを記述していく。

<details><summary>第1章</summary><div>

## 第1章　hello_app
・クラウドIDEで環境構築

・rvmを使って`ruby3.1.2`をインストール

　`$ rvm get stable`

　`$ rvm install 3.1.2`

　`$ rvm --default use 3.1.2`

・railsをインストールする

　rubyドキュメントをスキップする設定を`.gemrcファイル`に追加

　`$ echo "gem: --no-document" >> ~/.gemrc`

　`rails7.0.4`をインストール

　`$ gem install rails -v 7.0.4`

・`bundler2.3.14`をインストール

　`$ gem install bundler -v 2.3.14`

・cloud9環境のディスク容量を追加する

　`$ source <(curl -sL https://cdn.learnenough.com/resize)``

・`~/environment`で`hello_app`という名前のrailsアプリを新規作成

　バージョンを指定　`--skip-bundle`コマンドを省略すると、システム上で見つかる最も直近のバージョンのbundlerが使われることになる

　`$ rails _ 7.0.4 _ new hello_app --skip-bundle`

・Gemfileの中身を書き換え

・`config/environment/development.rb`にクラウドIDEからrailsサーバーへ接続する許可を記述

　`config.hosts.clear`

・railsサーバーを起動、初期画面が表示されることを確認

・MVC(model-view-controller)

　ブラウザからのリクエストをcontrollerが受け取り、model(データベースとの通信を担当)を対話して呼び出し、viewをレンダリングしてHTMLをブラウザに返す

・`application_controller`にhelloメソッドを定義

・`config/routes`でhelloメソッドで表示されるHTMLをrootに設定

・`localhost:3000`でhelloメソッドで定義したHTMLが表示されることを確認

・クラウドIDEのgitバージョンが2.17.1であったのでアップグレード　2.41.0に

　`$ source <(curl -sL https://cdn.learnenough.com/upgrade_git)``

### ・githubにリポジトリhello_app-secondを作成してプッシュ

　↓個人アクセストークン

```
　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
```

</div></details>

<details><summary>第2章</summary><div>

## 第2章　toy_app

・`rails new` で`toy_app`を作成

・gemfileを書き換えて`bundle install`第1章で作ったものに加え、"sassc-rails"をインストール

・第1章でもしたように、helloメソッドを定義、rootを設定、`config/environment/development.rb`に接続許可を設定

・railsサーバーを起動し、無事起動することを確認

### ・gtihubのリポジトリtoy_ app_secondを作成してpush

・scaffoldコマンドでUsersモデルを作成　カラムは`name:string`と`email:string`

・作ったデータベースをマイグレート

・scaffoldで作成したので、URLが~/usersに新しくページが自動で作成されていることを確認

・rootページを`users/index`に変更

・scaffoldはいろんなページを一気に作成してくれるので便利だが、データの検証やテストが行われていないなどの問題点が多々ある。

・Micropostモデルを作成　カラムは`content:text`と`user_id:integer`

・`models/micropost.rb`に投稿のバリデーションを作成　投稿を140字に制限

・`models/user.rb`にuser一人に複数のmicropostが紐づくように設定　`has_many :microposts`

・`models/micropost.rb`にmicropost一つにuser一人が紐づくように設定　`belongs_to :user`

・railsコンドールで紐づけがちゃんとできているか確認

・演習：ユーザーのshowページに、ユーザーの最初の投稿を表示させる

・演習：投稿のバリデーションを追加　空白だとエラーを返すように

・演習：Userモデルにバリデーションを追加　nameとemailが空白のときにエラーを返す

・ユーザーと投稿のページの行ったり来たりが面倒だったのでヘッダーに各一覧へのリンクを設置

### ・toy_appの作成終了　push

</div></details>

<details><summary>第3章</summary><div>

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

・`--skip-bundle`によってjavascriptを使うためのパッケージのインストールもスキップしているらしい　あとで手動で入れるよ

・gemfileを書き換え、bundleインストール

・このとき、production環境でしか使わないgemはインストールしないように設定することで、
developmentとtest環境ではSQLite、production環境ではpostgreSQLを使うようになる。この時点ではpostgreSQLはまだ未インストール

・gtihubにリポジトリrails-tutorial-secondを作成してpush

・第1章でもしたように、helloメソッドを定義、rootを設定、`config/environment/development.rb`に接続許可を設定

・gemfileをロックし、ここまでをpush

・rails g でコントローラ名「Static Pages」でHome、Helpページを作成

・新しいブランチstatic-pagesを作成し、そこにpush　`$ git push --set-upstream origin static-pages`としないとできなかった

・コントローラー作成をミスってもとに戻したいときは、`$ rails destroy ~~~~`とすればOK

・HomeページとHelpページをいろいろ修正

・Aboutページを手動で作るに当たって、まずはテストを作成する

・テストをパスするためにルーティング、コントローラーのメソッド、ビューを作成

・各ページにページタイトルを表示させる作業をしていく

・まずテストを作成`assert_select "title, "タイトル"``

・テストの最初にsetupメソッドを定義して重複を回避

・`application.html.erbファイル`のタイトル、各ページにprovideメソッドを設定することでタイトルが動的に切り替わるように

・演習：ルートを変更したことでroot_urlが利用できるようになった。これに対するテストを作成

・ここまでを"Static Pages作成終了"とcommitしてmainブランチにmergeし、push

・minitest reportersを導入

・Guardによるテストの自動化を導入　ターミナルで `$ bundle _2.3.14_ exec guard init` を実行

・生成されたGuardファイルを編集　編集後は新しいターミナルで `$ bundle _2.3.14_ exec guard` を実行しておけば自動でテストしてくれる

・ここまでを"テストのセットアップ完了"でcommitしてpush

・第4章でapplication_helperにタイトルを表示するヘルパーメソッドを追加

・ヘルパーメソッドを追加したことをpush

</div></details>

<details><summary>第5章</summary><div>

## 第5章　レイアウトを作成する

・git branchを作成　`filling-in-layout`

・ヘッダー、homeのhtmlを編集

・bootstrapをインストールする

・すべてのCSSを一つにまとめるため、カスタムCSSファイルを作成

・フッターのhtmlを編集

・ヘッダーとフッターのCSSを追加

・コンタクトページを追加

・各ページの名前付きルーティングを定義　テストを名前付きルーティングに書き換え

・結合テスト(integration_test)を作成 `$ rails g integration-test site-layout`

・ここまでをpush

・static_pagesの各ページの文章を修正

・Applicationヘルパーで使っているfull_titleメソッドのテストを作成

・ここまでをcommit

・ユーザー登録ページへのルーティングを作成していく

・Usersコントローラーを作成、newをSign upページとして作成

・ここまでをpush

</div></details>

<details><summary>第6章</summary><div>

## 第6章　ユーザーのモデルを作成する

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

