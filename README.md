# docker-centos7-unit

# 設定内容
- ロケール設定
- タイムゾーン設定
- ミドルウェアインストール
  - 運用ツール
  - NGINX
  - NGINX Unit
  - PHP関連ツール一式
  - アプリの設定登録
- yumキャッシュクリア
- 各ミドルウェアの設定ファイル配置
- 公開用ポートの設定
- スタートアップスクリプト実行(NGINX, NGINX Unit起動・設定用JSONファイル投入)

# 起動方法
- $ docker run --name unit -dit -p 80:80 -p 8300:8300 --privileged oshou/docker-centos7-unit:latest
- $ docker exec -it unit /bin/bash
