#!/bin/bash

# root権限チェック
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root or with sudo"
    exit 1
fi

# 設定値
SWAP_FILE="/swapfile"
SWAP_SIZE="4096"  # 4GB in MB

echo "Starting swap file setup..."

# 既存のswapファイルがある場合は削除
if [ -f "$SWAP_FILE" ]; then
    echo "Swap file already exists. Removing old swap file..."
    swapoff "$SWAP_FILE" 2>/dev/null || true
    rm "$SWAP_FILE" 2>/dev/null || true
fi

# swapファイル作成
echo "Creating ${SWAP_SIZE}MB swap file..."
dd if=/dev/zero of="$SWAP_FILE" bs=1M count="$SWAP_SIZE" status=progress
if [ $? -ne 0 ]; then
    echo "Failed to create swap file"
    exit 1
fi

# 権限設定
echo "Setting swap file permissions..."
chmod 600 "$SWAP_FILE"
if [ $? -ne 0 ]; then
    echo "Failed to set permissions"
    exit 1
fi

# swapとして初期化
echo "Setting up swap space..."
mkswap "$SWAP_FILE"
if [ $? -ne 0 ]; then
    echo "Failed to set up swap space"
    exit 1
fi

# swap有効化
echo "Enabling swap..."
swapon "$SWAP_FILE"
if [ $? -ne 0 ]; then
    echo "Failed to enable swap"
    exit 1
fi

# swap状態確認
echo "Verifying swap configuration..."
swapon -s

# 永続化設定
if ! grep -q "$SWAP_FILE" /etc/fstab; then
    echo "Adding swap to /etc/fstab..."
    echo "$SWAP_FILE none swap sw 0 0" >> /etc/fstab
fi

# キャッシュクリア
echo "Clearing system cache..."
sync && echo 3 > /proc/sys/vm/drop_caches

echo "Swap setup completed successfully!"