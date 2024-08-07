# homebrew
export PATH=/opt/homebrew/bin:$PATH
export PATH=/opt/homebrew/sbin:$PATH

# golang
export GOPATH=$HOME/Projects/golang
export PATH=$PATH:$GOPATH/bin

# inherited bash paths
export PATH=$HOME/bin:$PATH
export PATH=/usr/local/bin:$PATH

# node version manager
source ~/.nvm/nvm.sh

# do not require to write cd every time
setopt auto_cd

# LSD
alias ls='lsd'
alias l='ls -FL'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree --ignore-glob "node_modules"'
alias lta='ls --tree -a --ignore-glob "node_modules"'

# enhanced tools
alias vim='nvim'
alias cat='bat'

# git
alias g='git'
alias ga='git add'
alias gaa='git add .'
alias gs='git status'
alias gss='git status --short'
alias gcd='git checkout'
alias gcm='git checkout main' 
alias gclear='git fetch --prune && git branch -vv | grep ': gone]' | awk '{print $1}' | xargs git branch -D'
alias gp='git pull --rebase'
alias gP='git push origin HEAD'

# tmux
alias t='tmux'
alias ta='tmux attach -t'
alias tk='tmux kill-session -a'
alias tl='tmux ls'
alias tn='tmux new-session -s'

# initialize starship
eval "$(starship init zsh)"

# bun completions
#[ -s "/Users/nelson/.bun/_bun" ] && source "/Users/nelson/.bun/_bun"
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# zoxide
eval "$(zoxide init --cmd cd zsh)"

# shell gpt utilities
generate_commit_message() {
  git_diff=$(git diff --staged)
  if [[ -n $git_diff ]]; then
    sgpt_message=$(echo "$git_diff" | sgpt "Generate commit message, for my changes, be clear and informative, in 80 characters or less, use the conventional commits format")
    echo "- $sgpt_message" 
    echo "🙂 Is it OK? [Y/n]"
    read REPLY
    if [[ $REPLY =~ ^[Nn]$ ]]; then
      echo "🙅 Operation cancelled"
    else
      git commit -m "$sgpt_message"
      echo "👍 Commit done"
    fi
  else
    echo "😓 There are no staged changes"
  fi
}

alias gc=generate_commit_message

# python
if command -v pyenv 1>/dev/null 2>&1; then eval "$(pyenv init --path)"; fi
alias py=python3
alias pip=pip3

# enhanced autocompletion
fpath=(~/.docker/completions $fpath)
autoload -Uz compinit
compinit
