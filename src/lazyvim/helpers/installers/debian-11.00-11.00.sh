#!/bin/bash

set -euxo pipefail

apt update

env

pkgs=()

if [ $GIT = "true" ]; then
	pkgs+=("git")
fi

if [ $LAZYVIM_STARTER = "true" && $GIT != "true" ]; then
	pkgs+=("git")
fi

if [ $BUILD_ESSENTIAL = "true" ]; then
	pkgs+=("build-essential")
fi

if [ $WGET = "true" ]; then
	pkgs+=("wget")
fi

if [ $INSTALL_NVIM = "true" && $WGET != "true" ]; then
	pkgs+=("wget")
fi

if [ $CURL = "true" ]; then
	pkgs+=("curl")
fi

if [ $LAZYGIT = "true" && $CURL != "true" ]; then
	pkgs+=("curl")
fi

if [ $PYTHON3 = "true" ]; then
	pkgs+=("python3")
fi

if [ $PIP3 = "true" ]; then
	pkgs+=("python3-pip")
fi

if [ $PYTHON_IS_PYTHON3 = "true" ]; then
	pkgs+=("python-is-python3")
fi

if [ $RIPGREP = "true" ]; then
	pkgs+=("ripgrep")
fi

if [ $FD = "true" ]; then
	pkgs+=("fd-find")
fi

if [ $UNZIP = "true" ]; then
	pkgs+=("unzip")
fi

apt install -y "${pkgs[@]}"

if [ $LAZYGIT = "true" ]; then
	TEMP_DIR="$(mktemp -d)"
	pushd "$TEMP_DIR"
	LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
	curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
	tar xf lazygit.tar.gz lazygit
	sudo install lazygit /usr/local/bin
	popd
fi

# install neovim
if [ $INSTALL_NVIM = "true" ]; then
	TEMP_DIR="$(mktemp -d)"
	pushd "$TEMP_DIR"
	wget "https://github.com/neovim/neovim/releases/download/$NVIM_VERSION/nvim-linux64.tar.gz"
	tar xf nvim-linux64.tar.gz
	rm nvim-linux64.tar.gz
	# move the executable
	mv --force nvim-linux64/bin/nvim /usr/local/bin
	# --symbolic & --force flags does not exist in alpine & busybox
	ln -s -f /usr/local/bin/nvim /usr/bin
	# copy share files
	cp --recursive --update --verbose nvim-linux64/share/* /usr/local/share
	rm -rf nvim-linux64/share
	# copy libs
	cp --recursive --update --verbose nvim-linux64/lib/* /usr/local/lib
	rm -rf nvim-linux64/lib
	# copy man pages
	cp --recursive --update --verbose nvim-linux64/man/* /usr/local/man
	rm -rf nvim-linux64/man
	popd
fi

# install lazyvim starter
if [ $LAZYVIM_STARTER = "true" ]; then
	git clone https://github.com/LazyVim/starter ~/.config/nvim
	rm -rf ~/.config/nvim/.git
fi
