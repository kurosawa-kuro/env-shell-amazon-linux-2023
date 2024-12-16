.PHONY: setup setup-swap install install-docker install-nodejs chmod-scripts

# 初期セットアップ（権限付与→swap設定→インストール）
setup: chmod-scripts setup-swap nstall

# スクリプトに実行権限付与
chmod-scripts:
	@chmod u+x script/*.sh

# デフォルトのインストール（Dockerなし）
install: chmod-scripts
	@./script/setup-lib.sh nodejs

# Dockerを含むインストール
install-docker: chmod-scripts
	@./script/setup-lib.sh docker

# Node.jsのみインストール
install-nodejs: chmod-scripts
	@./script/setup-lib.sh nodejs

setup-swap: chmod-scripts
	@sudo ./script/setup-swap.sh

setup-key: chmod-scripts
	@./script/setup-key.sh
