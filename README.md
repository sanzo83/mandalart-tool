# Mandala Note

Rails製のマンダラート作成サービスです。

ログインは不要です。大切なノートは編集画面の「バックアップを保存」からJSONでダウンロードし、トップページの「バックアップを開く」から再開できます。同じブラウザでは入力中の内容も自動で下書き保存されます。

## ローカル（Docker）

Docker Desktopを起動してから、以下を実行します。SQLiteの開発DBはリポジトリ内の`db/development.sqlite3`に作成され、PostgreSQLコンテナは使用しません。

```sh
docker compose up --build
```

[http://localhost:3000](http://localhost:3000) を開きます。停止は `docker compose down` です。

## Cloud Run

`Dockerfile`の最終ステージはCloud Run向けの本番イメージです。PumaはCloud Runが渡す`PORT`で`0.0.0.0`に待ち受け、アセットはイメージ作成時に生成します。

Apple SiliconのローカルDockerで作ったARMイメージは、Cloud RunのLinux環境で動かないことがあります。Cloud Buildでビルドするのが安全です。

```sh
gcloud builds submit --tag REGION-docker.pkg.dev/PROJECT_ID/REPOSITORY/mandala-note:latest
gcloud run deploy mandala-note \
  --image REGION-docker.pkg.dev/PROJECT_ID/REPOSITORY/mandala-note:latest \
  --region REGION
```

Cloud Runのコンテナファイルシステムはインスタンス終了時に消えるため、現在のSQLite本番DBは一時的な編集用です。大切なマンダラートは必ずJSONバックアップをダウンロードしてください。マイグレーションはWebプロセス起動時ではなく、デプロイ時にCloud Run Jobなどで別途実行します。
