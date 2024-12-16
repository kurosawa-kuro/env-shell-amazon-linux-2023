# env-shell-amazon-linux-2023

```
sudo dnf install -y git make

git clone https://github.com/kurosawa-kuro/env-shell-amazon-linux-2023.git
cd env-shell-amazon-linux-2023
chmod u+x script/*

make setup
```

# Amazon Linux 2023 セットアップガイド

## 📋 前提条件
- Amazon Linux 2023 AMI
- EC2インスタンスへのSSHアクセス
- 適切なIAM権限

## 🚀 クイックスタート
```bash
# リポジトリをクローン
git clone https://github.com/kurosawa-kuro/env-shell-amazon-linux-2023.git
cd env-shell-amazon-linux-2023

# セットアップスクリプトを実行
./setup.sh
```

## 📦 インストールされるコンポーネント

### 基本システム
- システムアップデート
- 開発ツール（Git, Make）
- メモリ管理ツール

### 開発環境
- Node.js 18.x
- Docker & Docker Compose
- 開発用スワップ領域 (4GB)

### ユーティリティ
- メモリ管理スクリプト
- キャッシュクリアツール
- ログクリーニングツール

## 🔧 主要スクリプト

### setup-swap.sh
スワップ領域の設定を自動化
```bash
sudo ./setup-swap.sh
```

### memory-management.sh
メモリ関連の操作を簡略化
```bash
./memory-management.sh [check|clear|status]
```

### system-maintenance.sh
システムメンテナンス操作
```bash
./system-maintenance.sh [logs|cache|all]
```

## ⚙️ 設定ファイル

### .env
環境変数の設定
```env
NODE_VERSION=18
SWAP_SIZE=4096
```

## 📝 使用方法

### 1. メモリ管理
```bash
# メモリ状況確認
free -h

# キャッシュクリア
sudo sh -c 'sync && echo 3 > /proc/sys/vm/drop_caches'
```

### 2. Docker管理
```bash
# Dockerサービス開始
sudo systemctl start docker

# Docker Compose確認
docker-compose --version
```

### 3. Node.js管理
```bash
# Node.jsバージョン確認
node --version

# NPMキャッシュクリア
npm cache clean --force
```

## 🔍 トラブルシューティング

### メモリ関連
1. メモリ不足の症状
   - システムの応答が遅い
   - プロセスが強制終了される

2. 解決策
   ```bash
   # キャッシュクリア
   sudo sh -c 'sync && echo 3 > /proc/sys/vm/drop_caches'
   
   # スワップの確認
   swapon -s
   ```

### Docker関連
1. 権限エラー
   ```bash
   sudo usermod -aG docker $USER
   newgrp docker
   ```

2. サービス起動エラー
   ```bash
   sudo systemctl restart docker
   ```

## 📈 メンテナンス

### 定期的なタスク
1. システムアップデート
   ```bash
   sudo dnf update -y
   ```

2. ログクリーニング
   ```bash
   sudo sh -c 'find /var/log -type f -name "*.log" -exec truncate -s 0 {} \;'
   ```

3. Docker クリーンアップ
   ```bash
   docker system prune -af
   ```

## 🔒 セキュリティ考慮事項

1. SSHキーの管理
   - 適切なパーミッション設定
   - 定期的な鍵の更新

2. システム更新
   - セキュリティパッチの適用
   - 依存パッケージの更新

3. ファイアウォール設定
   - 必要なポートのみ開放
   - 不要なサービスの無効化
