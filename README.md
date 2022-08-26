# README

## 概要
rails製のマンダラート作成サービスです。（一応動く）

## ローカルでの動かし方

### dbの起動
- doc/dev/docker/docker-compose.ymlがあるのでそれを起動
```
docker-compose build
docker-compose up -d
```

### ライブラリインストール
```
bundle install
yarn install
```

### dbマイグレート
```
rake db:migrate
```

### railsアプリの起動
- カレントディレクトリでサーバー起動
```
rails s
```

http://localhost:3000

にアクセス
