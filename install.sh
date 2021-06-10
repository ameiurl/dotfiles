#!/bin/bash
set -e

echo '[*] pacman installing Neovim nodejs the_silver_searcher global ctags yarn'
sudo pacman -S neovim nodejs the_silver_searcher global ctags yarn

echo '[*] pip installing Neovim'
pip3 install neovim send2trash

# 判断是否有nvim文件夹，没有则创建
echo '[*] Preparing Neovim config directory ...'
if [ ! -d "~/.config/nvim/autoload" ]; then
  mkdir -p ~/.config/nvim/autoload
fi

if ! [ -e ~/.config/nvim/autoload/plug.vim ]; then
	echo "[*] Installing vim-plug"
	#curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
		#https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	git clone https://github.com/junegunn/vim-plug
	cp vim-plug/plug.vim  ~/.config/nvim/autoload/plug.vim
fi

# install config
ln -sf `pwd`/vim/vimrc ~/.config/nvim/init.vim

echo -e '[*] Running :PlugInstall within nvim ...'
nvim -c ':PlugInstall' -c ':UpdateRemotePlugins' \
	-c ':CocInstall coc-phpls' -c ':qall'

echo -e "[+] Done"
