#!/bin/bash

install_nodejs() {
    # Node.jsリポジトリ追加
    curl -fsSL https://rpm.nodesource.com/setup_18.x | sudo bash -

    # Node.jsインストール
    sudo yum install -y nodejs

    # バージョン確認
    node --version
    npm --version
}

install_docker() {
    # Dockerインストール
    sudo yum install -y docker

    # Docker Compose インストール
    sudo curl -L "https://github.com/docker/compose/releases/download/v2.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
}

clear_cache() {
    # キャッシュクリア
    sudo sh -c 'sync && echo 3 > /proc/sys/vm/drop_caches'
}

# メイン処理
if [ "$1" = "nodejs" ]; then
    install_nodejs
elif [ "$1" = "docker" ]; then
    install_docker
fi

clear_cache
