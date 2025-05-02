export PLUG_DIR=$HOME/.zim
if [[ ! -d $PLUG_DIR ]]; then
	curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
	# curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/zimfw/install/master/install.zsh
	rm ~/.zimrc
	ln -s ~/.config/zsh/zimrc ~/.zimrc
	source ~/.zim/zimfw.zsh
	zimfw install
fi
