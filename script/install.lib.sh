# Node.jsリポジトリ追加
curl -fsSL https://rpm.nodesource.com/setup_18.x | sudo bash -

# Node.jsインストール
sudo yum install -y nodejs

# バージョン確認
node --version
npm --version

# Dockerインストール
sudo yum install -y docker

# Docker Compose インストール
sudo curl -L "https://github.com/docker/compose/releases/download/v2.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose