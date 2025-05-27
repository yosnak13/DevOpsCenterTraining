# パイプライン運用

## 環境一覧

|用途|組織|エイリアス|
|-|-|-|
|開発用|Scratch組織|DevScratch|
|ステージング用|Scratch組織|StgScratch|
|本番用|Playground(Prod)環境|Prod|

---


## devhub認証

```shell
sf org login web --alias Prod
sf org login web --alias Prod --set-default-dev-hub
```

## スクラッチ組織作成

- 開発環境(7日間有効のスクラッチ)

```shell
sf org create scratch --definition-file config/dev-scratch-def.json --alias DevScratch --duration-days 7 --set-default
```

- ステージング環境(30日間有効のスクラッチ)

```shell
sf org create scratch --definition-file config/stg-scratch-def.json --alias StgScratch --duration-days 30
```

## デフォルト環境の切り替え

```bash
# dev
sf config set target-org=DevScratch
# stg
sf config set target-org=StageScratch
# prod
sf config set target-org=Prod
```
