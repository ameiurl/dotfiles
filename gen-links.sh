#!/bin/bash
set -e

CUR_DIR=$(realpath $(dirname "$BASH_SOURCE"))

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
    "$CUR_DIR/vim/vimrc | ~/.vimrc"
    "$CUR_DIR/vim/coc-settings.json | ~/.vim/coc-settings.json"
    "$CUR_DIR/gtags/gtags.vim | ~/.vim/gtags.vim"
    "$CUR_DIR/gtags/gtags-cscope.vim | ~/.vim/gtags-cscope.vim"
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
