# 第3回課題

## 行なったこと
- Cloud9の環境構築
- GitHubリポジトリのクローン
- 構成管理ツール、ライブラリ、依存関係の設定
- MySQLのセットアップ
- アプリのデプロイ

## アプリケーションサーバ

|  確認項目  |  結果  |
| ---- | ---- |
|  名前  |  puma  |
|  バージョン  |  5.6.5  |
|  APサーバーを終了後のアクセス  |  不可  |

![Rails](image03/rails.png)

APサーバーを終了後
![Error](image03/error.png)


## DBサーバー

|  確認項目  |  結果  |
| ---- | ---- |
|  名前  |  mysql  |
|  バージョン  |  8.0.33  |
|  DBサーバーを終了後のアクセス |  不可  |

![MySQL](image03/mysql.png)

DBサーバーを終了後
![DBError](image03/db-error.png)

## Railsの構成管理ツール

|  確認項目  |  結果  |
| ---- | ---- |
|  名前  |  Bundler  |
|  バージョン  |  (3.2.14)  |

## 感想
アプリをデプロイした際にホストドメインに接続できなかった。結果的に画面上部のPreviewの"Preview Running　Application"を押さないと表示されないことが判明した。
`bin/cloud9_dev`でAPサーバーを立ち上げているかと思いますが、これだけではアプリの実行はされないということでしょうか？
