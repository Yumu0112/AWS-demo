# 第5回課題の実行記録

## 行なったこと
- EC2上にrailsアプリをデプロイ
- APサーバーとWebサーバーに分けて起動する  
- ELBの追加
- S3の追加


## 組み込みサーバーにて動作確認
*以下はVPCの構築、EC2インスタンスの起動、RDSの作成とインスタンス作成後の手順  
インスタンスタイプをt2.smallに変更  

- バージョン確認

| lang   |   ver   |
| :----: | :-----: |
| ruby   |  3.1.2  |
| git    | 2.40.1  |
| mysql  | 8.0.34  |
| rbenv  |  1.2.0  |
| node.js| 15.5.0  |
| bundler| 2.3.14  |


  
1. yumのアップデート  

***  
- そもそもyumとは何か  
LinuxOSにおけるパッケージ管理ツール。  
yumは「RPM」というパッケージ管理を容易にするコマンドなどを提供するもので、 基本的には`yum`というコマンドを起動して操作や管理を行う。
*** 

  - EC2内のソフトウェアを最新にする  
  ``` sudo yum update -y ```  
　  　
2. 各プラグインをインストール  
``` sudo yum install git make gcc-c++ patch openssl-devel libyaml-devel libffi-devel libicu-devel libxml2 libxslt libxml2-devel libxslt-devel zlib-devel readline-devel ```  
  
3. Node.jsをインストール

  Node.jsのバージョン管理ツールnvmをインストールする   
  ``` curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash ```  

  .bash_profileを読み込む  
  ```  source ~/.bash_profile ```  

  Node.jsをバージョン指定でインストールする  
  ``` nvm install 15.5.0 ```  
  
4. rbenvをインストール

***  
- rbenvとは何か  
Rubyのバージョンを管理し、プロジェクト毎にRubyのバージョン切り替えて使える環境を実現してくれるツール　
*** 

  rbenv (rubyのバージョン管理ツール)をインストールする  
  ``` git clone https://github.com/sstephenson/rbenv.git ~/.rbenv ```  

  パスを通す  
  ``` echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile ```
  ``` echo 'eval "$(rbenv init -)"' >> ~/.bash_profile ```  

  設定ファイルを反映させる    
  ``` source ~/.bash_profile ```  
  
5. ruby-build  をインストール
***  
- ruby-buildとは何か  
異なるバージョンのRubyをコンパイルしインストールするための、 rbenv install コマンドを提供するrbenvのプラグイン　
*** 

  ruby-build (rubyのビルドツール)をインストールする  
  ``` git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build ```  

  ~/.rbenv/versions/*/bin/ 以下のファイルを ~/.rbenv/shims/ 以下にコピーする  
  ``` rbenv rehash ```   

  保存したディレクトリからrubyのインストールを実行  
  ``` 
  cd ~/.rbenv/plugins/ruby-build 
  sudo ./install.sh
  ```
  
6. Rubyとrailsのインストール

  バージョン指定をしてRubyをインストール  
  ```rbenv install -v```  

  railsをインストール  
  ```gem install rails```  
  
7. yarnをインストール

  下記コマンドでyarnをインストール    
  ```npm install yarn -g```  
  
8. MySQLをインストール

  ```sudo yum localinstall https://dev.mysql.com/get/mysql80-community-release-el7-1.noarch.rpm```  
  このコマンドで、MySQLのYUMリポジトリをシステムにインストール。    
  YUMリポジトリは、MySQLのパッケージをダウンロードしてインストールするための情報を提供している。

  ```sudo yum install --enablerepo=mysql80-community mysql-community-server```  
  このコマンドで、MySQLのコミュニティエディションのサーバーパッケージであるmysql-community-serverをインストール。  
  MySQLのサーバーはデータベースの本体であり、データの格納やクエリの処理を担当する。  

  ```sudo yum install --enablerepo=mysql80-community mysql-community-devel```  
  このコマンドで、MySQLのコミュニティエディションの開発パッケージであるmysql-community-develをインストール。  
  開発パッケージにはMySQLを開発するために必要なヘッダーファイルやライブラリが含まれている。  
  

9. アプリのデプロイ準備

  デプロイするアプリのリポジトリをクローン  
  ``` git clone https://github.com/yuta-ushijima/raisetech-live8-sample-app.git ```  

  ディレクトリに移動して依存関係をインストール  
  ``` bundle install ```  

  DBを立てる  
  ``` rails db:create ```  

***
  
しかし、Railsアプリケーションがデータベースの設定ファイル(config/database.yml)を見つけることができないため、rails db:createコマンドが失敗。   
そのため、  
  ```cp config/database.yml.sample config/database.yml```  
でdatabase.ymlを作成。  
    
さらに下記エラーでソケットファイルが見つからないため、パスを変更   
   
`Mysql2::Error::ConnectionError: Can't connect to local MySQL server through socket '/tmp/mysql.sock' (2)`    
  
また、DBサーバーとの接続設定(ユーザー、パスワード、エンドポイントなど)を入力、変更したらマイグレーション   
    　　  
``` rails db:migrate ```    
  
***

  railsアプリをコンパイルして起動    
  ```  
  rails assets:precompile  

  ```

🎉サイトにアクセスすると表示  

  
***



## APサーバーとWebサーバーでの起動  

- rack: rails s コマンドを実行した時に起動する、rubyで書かれたwebフレームワークをうまく動かすためのアプリケーションサーバー。   
  
rubyで書かれた様々なwebフレームワークとwebサーバーを繋いでくれるもので、webサーバー、webフレームワークのどちらが変わってもサイトとしてうまく機能をするようにしてくれる。       
  
- Nginx: クライアントからのリクエストを受け、なんらかの処理（SSLや圧縮など）を行なうWebサーバー  
      
- Unicorn: NginxとRackをうまく繋いでくれるWebサーバとアプリケーションサーバの中間のような存在    
 

### Nginxの設定

1. yumをアップデートし、yum経由でNginxのインストール  
  ``` sudo yum install nginx ```   
  バージョンを確認  
  ` nginx version: nginx/1.24.0 `   
   
2. セキュリティのインバウンドルールを追加  
  
  パブリックIPのうち、ポート番号80を開ける  

3. Nginxを起動    
  
  ``` sudo service nginx start ```    

🎉サイトにアクセスするとNginxの画面が表示  

4. Nginx の設定ファイルを作成    
  
  /etc/nginx/conf.d 以下に rails.conf を新規作成して、以下を追加  

  ```
  upstream unicorn {
    server unix:/home/ec2-user/raisetech-live8-sample-app/tmp/unicorn.sock;
  }

  server {
    listen 80;
    server_name "サーバーのパブリックIP";
    root /home/ec2-user/raisetech-live8-sample-app/public;

    location ^~ /assets/ {
      gzip_static on;
      expires max;
      add_header Cache-Control public;
    }

    location @unicorn {
      proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
      proxy_set_header Host $http_host;
      proxy_redirect off;
      proxy_pass http://unicorn;
    }

    try_files $uri/index.html $uri @unicorn;
    error_page 500 502 503 504 /500.html;
  }  
```  
  
### Unicornの設定  
  
1. Unicorn.rbをconfig直下に配置し、以下を記述    

  ```
  worker_processes Integer(ENV["WEB_CONCURRENCY"] || 3)
  timeout 15
  preload_app true

  app_directory = '/home/ec2-user/raisetech-live8-sample-app'
  listen '/home/ec2-user/raisetech-live8-sample-app/tmp/unicorn.sock'
  pid    '/home/ec2-user/raisetech-live8-sample-app/tmp/unicorn.pid'

  before_fork do |server, worker|
    Signal.trap 'TERM' do
      puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
      Process.kill 'QUIT', Process.pid
    end

    defined?(ActiveRecord::Base) and
      ActiveRecord::Base.connection.disconnect!
  end

  after_fork do |server, worker|
    Signal.trap 'TERM' do
      puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
    end

    defined?(ActiveRecord::Base) and
      ActiveRecord::Base.establish_connection
  end

  stderr_path File.expand_path('log/unicorn.log', ENV['RAILS_ROOT'])
  stdout_path File.expand_path('log/unicorn.log', ENV['RAILS_ROOT'])

  ```  
  
2. `vi config/environments/development.rb` で下記を変更   

  `config.assets.debug = true` -> false に変更。  

### NginxとUnicornを起動して接続

  - Nginxサーバー再起動    
  `sudo systemctl restart nginx`   

  - Unicornサーバー起動   
  `bundle exec unicorn -c /home/ec2-user/raisetech-live8-sample-app/config/unicorn.rb -E development -D`  

***

ログの確認方法

Unicorn:
`vi log/unicorn.log`  
  
Nginx:
`sudo vi /var/log/nginx/error.log`  
    
***

🎉接続完了  

## ELBの追加

1. ターゲットグループの作成    
ロードバランサーはターゲットグループに指定したポートとプロトコルを使用して登録済みターゲットにリクエストを送信するため、EC2インスタンスを負荷分散先として指定    
  
2. ロードバランサーの作成  
新規セキュリティグループを作成、タイプ:HTTP、ポート番号:80、ソース:0.0.0.0/0のインバウンドグループを作成  
  
3. DNSでロードバランサーに接続    
アプリケーション側に許可を付与  

  `config.hosts << "lec05-test-alb-001-369732328.us-east-1.elb.amazonaws.com"`  

🎉分散完了    
   
## S3の追加  
  
S3にデータを保存するには以下が必要  
バケット: オブジェクトのコンテナのこと  
オブジェクト: ファイルと、そのファイルを記述している任意のメタデータのこと   
  
オブジェクトを保存するにはバケットを作成し、オブジェクトをバケットにアップロードする。  

1. S3バケットの作成  

2. セキュリティグループを作成  

3. ポリシーを追加

4. IAMでアクセスキーの生成  

6. `development.rb`の設定を変更
`config.active_storage.service = :amazon`

5. Railsアプリケーションの暗号化された機密情報（credentials）を編集
 ```
 cd /raisetech-live8-sample-app/config/credentials/

 # 暗号化された認証情報やAPIキー、パスワードなどの機密情報を管理するためのもので、このコマンドを実行すると環境ごと（例：development、productionなど）に対応するconfig/credentialsファイルがエディタが開かれる  
 EDITOR=vim rails credentials:edit --environment development

 aws:
  access_key_id: アクセスキー
  secret_access_key: シークレットアクセスキー
  active_storage_bucket_name: バケットの名前
 
 ```

が、なぜか失敗したので、config/storage.ymlに直接入力し、サーバーを再起動　　

🎉Nginxとunicornを再起動してサイトにアクセスする

