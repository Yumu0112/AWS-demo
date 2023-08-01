# 第12回課題
  
## CircleCiテスト

- プロジェクトをセットアップ  
  
- 下記エラーが発生  
  
```

W2031 You must specify a valid Default value for SSHCidrIp (x.x.x.x/x). Valid values must match pattern x.x.x.x/y
cloudformation/ec2_test.yml:16:5

W3005 Obsolete DependsOn on resource (CFnVPCIGW), dependency already enforced by a "Ref" at Resources/PublicRoute/Properties/GatewayId/Ref
cloudformation/vpc_test.yml:102:5


Exited with code exit status 4

```  
  
SSHCidrIpの形式と、CFnVPCIGWでの不要なリソースが記述されていることによるエラー  
こちらを解消して再度実行  
  
