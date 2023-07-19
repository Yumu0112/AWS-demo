# 第4回課題

## 行なったこと
- VPCの構築
- EC2インスタンスの作成
- RDSインスタンスの作成
- SSHでEC2インスタンスに接続
- EC2にMySQLをインストール
- EC2からRDSに接続git 

## VPCの構築

![vpc-setup](image04/vpc-info.png)  

![vpc-list](image04/vpc-list.png)


## EC2インスタンスの作成

![ec2-setup](image04/ec2-info.png)

![security](image04/ec2-sec.png)


## RDSインスタンスの作成

![rds-setup](image04/rds-info.png)


## SSHでEC2インスタンスに接続

SSH接続時にタイムアウトエラーにより接続拒否の事象が発生。  

→セキュリティグループのインバウンドルールでSSH接続時のIPアドレスの許可を追加  
![ec2-start](image04/ec2-up.png)
![add-rule](image04/sec-inbound.png)


## EC2にMySQLをインストール
MySQLにログインしようとしたところ、コマンドがないとのこと。  
インスタンス内にMySQLがインストールされていないため、yum経由でインストール。  
また、SSH接続時と同様にタイムアウトエラーの接続拒否が発生したため、許可を追加（上記画像に記載）  
![mysql-connect](image04/rdb-connect.png)
