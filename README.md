# cake_demo
since 2013-6-1 | 2021-6-30

CRUD画面（一覧、新規追加、編集、削除）の見本システムです。

パッケージ的なもので、このシステムを元に様々なWEBアプリを開発しています。
元々は純粋にCakePHPの規約に従ったシステムでした。
しかし、現在はSPA（Ajax)式が主流です。
当システムも数年前からJavaScriptによるSPA式になりました。
また、Laravelも念頭に置くようになり、CakePHPに依存しないソースコードになりつつあります。


2013年からバージョンアップを重ねてきました。
この見本システムから数多くのWEBアプリを開発してきました。
WordPressのプラグインも作成したことがあります。
2021年現在もテストや改良を繰り返し清廉しています。


jQueryに依存しています。
レイアウトはBootstrap4に依存しています。


以下の機能を備えています。
* 一覧表示
* 追加/編集/複製/削除/抹消
* 検索/詳細検索
* 初期戻し機能（リセットボタン）
* 列表示切替機能
* セッションクリア機能
* スマホ用一覧
* ページネーション
* 一括削除/有効
* ソート機能
* 行入替機能
* 一般モードとログインモードの切替
* CSVエスポート機能
* ユーザー管理画面
* ファイルアップロード機能
* ユーザー管理画面
* サインイン画面（アカウント登録機能）


## 今後の予定
兄弟システムのLaravel版がメインになりつつあります。
Vue.jsも取り入れていく予定です。



------

## 見本サイトURL

<https://amaraimusi.sakura.ne.jp/cake_demo/>


------

## 開発に必要なスキル

最低限のスキルとしてGitHubに関する知識が必要です。

バックエンド側で必要とするスキルはPHP, MySQL, CakePHP2.x系です。

フロントエンド側で必要とする技術はJavaScript ES6(ES2015), jQuery, Vue.js, Gulp, npm(Node.js)です。

------

## GitHub
<https://github.com/amaraimusi/cake_demo>

------

# 開発の準備
開発にはGitやphpの知識が必須になります。WEBシステム開発経験者向けの解説ですので詳しい説明は割愛します。

開発環境は各自でご用意ください。推奨環境はWindows10 + xampp（2021年6月時点で最新のもの）です。

GitHubにてプロジェクトをダウンロードできます。

<https://github.com/amaraimusi/cake_demo>

データベースはMySQLです。

開発用にテストデータ（cake_demo.sql）を用意しています。
farmin_food.sqlはphpmyadminなどでインポートできるようになっています。

[doc/cake_demo.sql](doc/cake_demo.sql)

------

## テスト用のアカウント

syoutokutaisi@example.com
yasigani@example.com
syo_umu_tennou@example.com
など他多数
パスワードはすべて「abcd1234」

------


##動作環境
php 7.4 MariaDB 10系

DBはMySQL5.6、MySQL8などでも可。

Chrome, Edge, Firefoxなどの主流なブラウザで動作。
スマートフォンやタブレットなどの主要ブラウザで動作。


------

## 設計図

なし


------

## ストレージ

一般ユーザーがアップロードした画像やファイルは以下のパスに保存されます。

/farmin_food/public/app/webroot/storage

------

