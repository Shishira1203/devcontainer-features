#!/bin/bash

set -euxo pipefail

apt update

env

pkgs=()

if [ $GIT = "true" ]; then
	pkgs+=("git")
fi

if [ $BUILD_ESSENTIAL = "true" ]; then
	pkgs+=("build-essential")
fi

if [ $WGET = "true" ]; then
	pkgs+=("wget")
fi

if [ $CURL = "true" ]; then
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

if [ $UNZIP = "true" ]; then
	pkgs+=("unzip")
fi

apt install -y "${pkgs[@]}"

# install neovim
if [ $INSTALL_NVIM = "true" ]; then
	TEMP_DIR="$(mktemp -d)"
	pushd "$TEMP_DIR"
	apt install -y wget
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
	apt install -y git
	git clone https://github.com/LazyVim/starter ~/.config/nvim
	rm -rf ~/.config/nvim/.git
fi
