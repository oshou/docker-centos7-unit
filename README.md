# docker-centos7-unit

# 設定内容
- ロケール設定
- タイムゾーン設定
- インストール
  - 運用ツール
  - nginxインストール
  - NginxUnitインストール
  - PHP関連ツール
  - アプリの設定登録
- yumキャッシュクリア
- アプリ用ポートの開放

# 起動方法
- $ docker pull oshou/docker-centos7-unit:latest
- $ docker run --name unit -dit -p 80:80 -p 8300:8300 --privileged oshou/docker-centos7-unit /sbin/init
- $ docker exec -it unit /bin/bash
