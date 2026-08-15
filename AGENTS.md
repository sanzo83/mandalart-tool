# Mandala Note: 開発ガイド

## プロジェクト概要

- Rails 8.0 / Ruby 3.2.11 / SQLite のマンダラート作成アプリ。
- ログイン機能はない。ノートはランダムなアクセストークンを含むURLで編集する。
- 永続的に残したい成果物は、利用者がJSONバックアップとしてダウンロードし、トップページから復元する設計。

## 基本方針

- 既存の未コミット変更はユーザーの作業として扱い、無関係な変更を戻したり整形したりしない。
- 依存関係・Ruby/Railsのバージョンを変更する場合は、段階的に更新し、テストを実行する。
- 新しい認証、外部DB、フロントエンドのビルドツールは、明示的な要望なしに追加しない。
- 画面文言とREADMEは日本語を維持する。

## ローカル開発

- 必要なRubyは `.ruby-version` に従う（現在は `3.2.11`）。
- Docker Desktopを起動して `docker compose up --build` を実行し、`http://localhost:3000` を開く。
- Dockerを使わない場合は、依存関係を入れたうえで `bundle exec rails db:prepare` と `bundle exec rails server` を使う。
- 開発用SQLite DBは `db/development.sqlite3`。PostgreSQLサービスは使わない。

## 検証

変更の内容に応じて、可能な範囲で以下を実行する。

```sh
rbenv exec bundle exec rails test
rbenv exec bundle exec rspec
RAILS_ENV=production rbenv exec bundle exec rails assets:precompile
git diff --check
```

- テストやアセット生成で作られたログ・キャッシュ・SQLiteファイルは、意図した変更でなければコミットに含めない。
- Dockerイメージを変更した場合は、Docker Desktopが利用可能なら `docker compose build` も確認する。

## データとセキュリティ

- レコードの参照・更新・削除では、連番IDではなく `access_token` を使う既存のアクセス制御を保つ。
- JSONインポートは既知の項目だけを受け入れ、利用者がダウンロードしたバックアップとの互換性を壊さない。
- ブラウザ内の下書き（localStorage）は補助機能であり、重要データの保存先として扱わない。
- 秘密情報（`config/master.key`、`.env`、認証情報）をコミット・Dockerイメージ・ログへ含めない。

## Cloud Run

- 本番コンテナはCloud Runが渡す `PORT` でPumaを待ち受ける。
- Cloud Runのコンテナファイルシステムは一時的。SQLiteは本番の永続ストアとして使わない。
- 本番でのマイグレーションはWebプロセス起動時に行わず、デプロイ時のCloud Run Jobなどで別途実行する。
- Apple Siliconローカルで作ったイメージを直接使わず、デプロイ用イメージはCloud Buildでビルドする。
