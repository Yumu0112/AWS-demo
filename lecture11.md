# 第11回課題
  
ServerSpecにて下記項目を確認するテストをデモ  
- Nginx, Gitのインストール  
- ポート番号80がリッスンされている
- MySQLのバージョンが8.0.34
- サーバからのレスポンスがステータス200である  
  

## 実行結果

```
$ rake spec

Package "nginx"
  is expected to be installed

Package "git"
  is expected to be installed

Port "80"
  is expected to be listening

Command "curl http://127.0.0.1:#{listen_port}/_plugin/head/ -o /dev/null -w "%{http_code}\n" -s"
  stdout
    is expected to match /^200$/

Command "mysql --version"
  stdout
    is expected to contain "mysql  Ver 8.0.34"

Finished in 0.13798 seconds (files took 0.48956 seconds to load)
5 examples, 0 failures
```