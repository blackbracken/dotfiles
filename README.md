# gearbox

## セットアップ

1. [Homebrew](https://brew.sh/) をインストールする
2. このリポジトリを clone する
3. `./setup.sh` を実行する
   - `Brewfile` のパッケージをインストール
   - `config/deploy_all.sh` で各コンフィグを配置（`~/.zshrc` には `config/zsh/rc_util.sh` を読み込む1行を追記）
   - `mise install` で mise 管理のツールをインストール
4. シェルを再起動する
