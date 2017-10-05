# docker-centos7-unit

# 設定内容
- ロケール設定
- タイムゾーン設定
- インストール
  - 運用ツール
  - Nginx
  - Nginx Unit
  - PHP関連ツール
  - アプリの設定登録
- yumキャッシュクリア
- 各ミドルウェアの設定ファイル配置
- 公開用ポートの設定

# 起動方法
- $ docker run --name unit -dit -p 80:80 -p 8300:8300 --privileged oshou/docker-centos7-unit
- $ docker exec -it unit /bin/bash
