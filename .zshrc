eval "$(starship init zsh)"

# Zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [[ -r "${ZINIT_HOME}/zinit.zsh" ]]; then
  source "${ZINIT_HOME}/zinit.zsh"

  # zsh plugins
  zinit light zsh-users/zsh-completions
  zinit light zsh-users/zsh-autosuggestions
  zinit ice depth=1; zinit light jeffreytse/zsh-vi-mode

  # Snippets
  zinit snippet OMZL::git.zsh
  zinit snippet OMZP::git
else
  print -u2 "zinit not found at ${ZINIT_HOME}; skipping plugins"
fi

# Load completions
autoload -Uz compinit
if [[ -n "${ZDOTDIR:-$HOME}/.zcompdump"(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi
(( ${+functions[zinit]} )) && zinit cdreplay -q
if (( ${+functions[zinit]} )); then
  zinit light Aloxaf/fzf-tab
  zinit light zsh-users/zsh-syntax-highlighting
fi

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt append_history
setopt extended_history
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt hist_reduce_blanks

source "$HOME/.aliases.zsh"

# Shell integrations
eval "$(rbenv init - zsh)"
eval "$(nodenv init -)"
eval "$(jenv init -)"

# Java
java_home="$(jenv javahome 2>/dev/null)"
if [[ -n "$java_home" ]]; then
  export JAVA_HOME="$java_home"
  path=("$JAVA_HOME/bin" $path)
fi
unset java_home

eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
