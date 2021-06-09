#!/bin/bash
set -e

CUR_DIR=$(realpath $(dirname "$BASH_SOURCE"))

# 判断是否有nvim文件夹，没有则创建
echo '[*] Preparing Neovim config directory ...'
if [ ! -d "~/.config/nvim/autoload" ]; then
  mkdir -p ~/.config/nvim/autoload
fi

echo '[*] pacman installing Neovim nodejs the_silver_searcher global yarn'
sudo pacman -S neovim nodejs the_silver_searcher global yarn

echo '[*] pip installing Neovim'
pip3 install neovim send2trash

if [ ! -d "./vim-plug" ]; then
echo '[*] Downloading vim-plug ...'
#curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    #https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
git clone https://github.com/junegunn/vim-plug
cp vim-plug/plug.vim  ~/.config/nvim/autoload/plug.vim
fi

function err() {
    echo $* >&2
    exit
}

function linkfile() {
    if [[ $# -ne 2 ]]; then
        err "Arg number must eq 2"
    fi

    src=$1
    dest=$2
    if [[ -L $dest ]]; then
        rm -f $dest
        echo "Link file $dest exists, remove it first"
    fi

    ln -s $src $dest
    echo "Link $src to $dest"
}

declare -a LINK_PAIRS

# Use array instead of map cause bash < 4 do not supprot
# associated array
#FISH_CONFIG_DIR="~/.config/fish"
LINK_PAIRS=(
    "$CUR_DIR/vim/vimrc | ~/.config/nvim/init.vim"
    "$CUR_DIR/vim/coc-settings.json | ~/.config/nvim/coc-settings.json"
    "$CUR_DIR/git/gitconfig | ~/.gitconfig"
    "$CUR_DIR/tmux/tmux.conf | ~/.tmux.conf"
    "$CUR_DIR/zsh/zshrc | ~/.zshrc"
)


function addlinks() {
    if [[ $# -ne 2 ]]; then
        err "Arg number must eq 2"
    fi

    src=$1
    dest=$2
    if [[ ! -d $src ]]; then
        err "$src must be a dir"
    fi

    for file in $(ls $src); do
        link_pair="$src/$file | $dest/$file"
        LINK_PAIRS+=("$link_pair")
    done
}

#addlinks "$CUR_DIR/fish/functions" $FISH_CONFIG_DIR/functions

for pair in "${LINK_PAIRS[@]}"; do
    src=$(echo $pair | awk -F'\|' '{print $1}' | awk '{$1=$1};1')
    dest=$(echo $pair | awk -F'\|' '{print $2}' | awk '{$1=$1};1')
    # expand tilde
    eval src=$src
    eval dest=$dest
    linkfile $src $dest
done

echo -e "[+] Done, welcome to \033[1m\033[92mNeoVim\033[0m! Try it by running: nvim/vim. Want to customize it? Modify ~/.config/nvim/init.vim"
