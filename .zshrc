eval "$(goenv init -)"
eval "$(rbenv init - zsh)"
eval "$(nodenv init -)"
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="geoffgarside"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

alias vim="nvim"
alias gs="git status"
alias gd="git diff"
alias ga="git add ."
alias gc="git commit"
alias gp="git push"
alias gpu="git pull"
alias gck="git checkout"

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#666666"
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)

export ANDROID_HOME=$HOME/Library/Android/sdk
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# bun completions
[ -s "/Users/jeroen/.bun/_bun" ] && source "/Users/jeroen/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
