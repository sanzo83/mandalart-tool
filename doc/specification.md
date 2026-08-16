# Mandala Note 仕様書

## 1. 概要

Mandala Note は、ログインなしでマンダラートを作成・編集するRailsアプリケーションです。

- 中心目標、8つのテーマ、各テーマの8つの行動を入力できる。
- 大切な内容はJSONバックアップとして利用者自身がダウンロードし、あとで再読み込みする。
- 同じブラウザでは、編集途中の内容をlocalStorageにも一時保存する。
- アカウントや共有機能は持たない。

## 2. 利用フロー

1. トップページで新規作成する、またはJSONバックアップを開く。
2. 中心目標と8つのテーマを入力する。
3. 9個の3×3マスで構成される編集画面で、各テーマの行動を入力する。
4. 必要に応じて一時保存、JSONバックアップのダウンロード、印刷/PDF保存を行う。

## 3. データ仕様

### records テーブル

| カラム | 型 | 制約 | 用途 |
| --- | --- | --- | --- |
| `id` | integer | 主キー | Rails内部の識別子 |
| `data` | JSON | 任意 | マンダラートの入力内容 |
| `access_token` | string | 必須・一意 | 編集/削除用URLの識別子 |
| `created_at` | datetime | 必須 | 作成日時 |
| `updated_at` | datetime | 必須 | 更新日時 |

`access_token` は `has_secure_token` で生成されます。ログインはなく、このトークンを含むURLを知る人がレコードを開けるため、編集URLは共有しない前提です。

### data JSON

`data` には以下のキーを保存します。値は文字列です。

| キー | 件数 | 内容 |
| --- | ---: | --- |
| `goal` | 1 | 中心目標 |
| `main_target1` ～ `main_target8` | 8 | 中心目標を実現するためのテーマ |
| `target1_1` ～ `target8_8` | 64 | 各テーマを具体化する行動 |

インポート時は上記の既知キーだけを受け入れ、各値を最大500文字へ切り詰めます。JSONは `{ "data": { ... } }` 形式と、入力内容を直接置いた形式の両方を受け入れます。

### ブラウザセッションとlocalStorage

| 保存先 | キー/内容 | 役割 |
| --- | --- | --- |
| Railsセッション | `recent_record_tokens`（最大20件） | 「一時ノート」画面に表示するレコードの一覧 |
| localStorage | `mandala-note-draft-<access_token>` | サーバー保存より新しい編集中データの復元 |

これらは補助的な一時データです。端末・ブラウザを変えても残したい内容はJSONバックアップを使用します。

## 4. 画面とルーティング

| HTTPメソッド | パス | 処理 |
| --- | --- | --- |
| `GET` | `/` | トップページ、新規作成とバックアップ読込の入口 |
| `GET` | `/main/index` | このブラウザで最近扱ったノートの一覧 |
| `GET` | `/main/new` | 新規作成フォーム |
| `POST` | `/main/create` | ノートを作成 |
| `POST` | `/main/import` | JSONバックアップを読み込み、新しいノートとして作成 |
| `GET` | `/main/:token/edit` | ノートを編集 |
| `PATCH` | `/main/:token` | ノートを一時保存 |
| `DELETE` | `/main/:token` | ノートを削除 |

`id`をURLに使わず、`access_token`でレコードを検索します。

## 5. 技術構成

| 区分 | 採用技術 |
| --- | --- |
| 言語 | Ruby 3.2.11 |
| Webフレームワーク | Rails 8.0.5.1 |
| DB | SQLite 3（`sqlite3` gem） |
| Webサーバー | Puma 6 |
| アセット配信 | Propshaft |
| JavaScript | Importmap、Turbo、Stimulus |
| CSS | ブラウザでそのまま利用できる通常のCSS |
| テスト | Minitest、RSpec |
| ローカル実行 | Docker Compose |
| 本番想定 | Google Cloud Run |

Node.js、Yarn、Webpack、Sassコンパイラは使用しません。

## 6. 実行・デプロイ

### ローカル開発

Docker Desktopを起動して、リポジトリ直下で実行します。

```sh
docker compose up --build
```

`http://localhost:3000` でアプリを開きます。開発DBは `db/development.sqlite3` を使います。コンテナ内の `log` と `tmp` はDockerボリュームへ分離され、Git管理ファイルを更新しません。

### 本番（Cloud Run）

- `Dockerfile` はdevelopmentとproductionのマルチステージ構成。
- productionイメージ作成時にPropshaftのアセットを事前生成する。
- PumaはCloud Runが渡す `PORT` を使い、`0.0.0.0` で待ち受ける。
- Apple Siliconのローカルイメージは使わず、Cloud BuildでLinux向けイメージを作成する。
- DBマイグレーションはWebプロセス起動時ではなく、Cloud Run Jobなどで別途実行する。

## 7. データ永続化に関する制約

Cloud Runのコンテナファイルシステムは一時的です。現在のproduction SQLite DB（`db/production.sqlite3`）は、インスタンスが終了すると失われる可能性があります。

そのため、現時点では以下を前提とします。

- Cloud Run上の保存データは一時的な編集用データ。
- 成果物の永続保存は、JSONバックアップまたは印刷/PDF保存で利用者が行う。
- 永続的なサーバー側保存が必要になった場合は、Cloud SQLなどの外部DBを別途導入する。

## 8. 主な検証コマンド

```sh
rbenv exec bundle exec rails test
rbenv exec bundle exec rspec
RAILS_ENV=production rbenv exec bundle exec rails assets:precompile
docker compose up --build
git diff --check
```
