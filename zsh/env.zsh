export PATH=$HOME/.local/bin:$PATH
export PATH=$PATH:/usr/local/bin
export XDG_CONFIG_HOME=$HOME/.config
export EDITOR=nvim
export SUDO_EDITOR=/usr/local/bin/nvim
export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890
# dsh/Node 不支持 SOCKS，且 7891 未监听；清掉旧 shell 里可能残留的值
unset all_proxy ALL_PROXY
