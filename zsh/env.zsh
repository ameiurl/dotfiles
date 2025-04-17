export PATH=$HOME/.local/bin:$PATH
export PATH=$PATH:/usr/local/bin
export XDG_CONFIG_HOME=$HOME/.config
export EDITOR=nvim
export SUDO_EDITOR=/usr/local/bin/nvim
export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7891

# if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    # tmux attach -t main 2>/dev/null || (tmux new-session -s main && exit)
# fi
if [ -z "$TMUX" ]; then
  exec tmux new-session -A -s main
fi
