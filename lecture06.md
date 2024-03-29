# 第6回課題

## イベントの確認
  
![events](image06/events.png)    

### イベント名: CreateBucket

- ユーザー名  
  
- 発信元IP  
  
- イベントID  
  
***  
  
## CloudWatchでアラーム通知の設定

 - CloudWatch上でアラートを設定  
    EC2のヘルスチェックが失敗している場合にカウントするメトリクスを利用  
  
 - 動作確認としてNginxサーバーを停止し、502を発生させるとメールが送られてくるかを確認  
   
 - 正常に動作している場合はアラート状態は解消されていることとHealthyの通知メールを確認
  
![set-alart](image06/set-alart.png)  
  
メール通知  
  
![notification](image06/notification.jpeg)  
  
サーバー再起動後  
  
![restart](image06/hearthcheck.png)  
  
![restartNotice](image06/ok-notification.jpeg)  

***
  
## 利用料の見積もり  
  
- 現在までの利用料  
  
見積もり
→ https://calculator.aws/#/estimate?id=7097ce21acb2dc2c4a35fcb2aa8eb8d9286e6eed 
  

![costs](image06/billing.png)  
  
- 無料利用枠  
  
![free1](image06/free1.png)  
  
![free2](image06/free2.png)  
