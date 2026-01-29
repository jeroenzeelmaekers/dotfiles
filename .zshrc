# Starship prompt
eval "$(starship init zsh)"

# Homebrew setup
eval "$(/opt/homebrew/bin/brew shellenv)"

# Zinit installation
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit ice depth=1; zinit light jeffreytse/zsh-vi-mode

# Snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --color=always $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza --color=always $realpath'

# Alias
alias ls='eza --color=always'
alias cat="bat"
alias vim='nvim'
alias lg='lazygit'

# Shell integrations
eval "$(rbenv init - zsh)"
eval "$(nodenv init -)"
eval "$(jenv init -)"

eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
