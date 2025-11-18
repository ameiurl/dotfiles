alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias tmux='tmux -2'
alias vi='nvim'
alias vim='nvim'
alias lg='lazygit'
alias yz='yazi'
alias j='jobs'
# git
alias gst='git status'
alias ga='git add'
alias gcmsg='git commit -m'
alias ggpush='git push'
alias ggpull='git pull'

alias cc="claude --dangerously-skip-permissions" 
alias cc-glm="ANTHROPIC_AUTH_TOKEN=724ece6cdc05461ab0572959371a47da.zGVbVtZrCJvEK2Ti \
ANTHROPIC_BASE_URL=https://open.bigmodel.cn/api/anthropic \
ANTHROPIC_SMALL_FAST_MODEL=GLM-4.6 \
ANTHROPIC_MODEL=GLM-4.6 \
claude --dangerously-skip-permissions"
alias cc-kimi="ANTHROPIC_AUTH_TOKEN=your-token \
ANTHROPIC_BASE_URL=https://api.moonshot.cn/anthropic \
ANTHROPIC_MODEL=kimi-k2-0905 \
claude --dangerously-skip-permissions"
