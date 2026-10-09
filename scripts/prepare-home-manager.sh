#!/bin/bash
set -euo pipefail

backup_root="$HOME/.local/state/dotfiles-migration/$(date +%Y%m%d-%H%M%S)"
paths=(
  .zshrc
  .zshenv
  .aliases.zsh
  .config/aerospace
  .config/bat
  .config/ghostty
  .config/lazygit
  .config/nvim
  .config/opencode
  .config/starship.toml
  .config/tmux
  .config/yazi
)

mkdir -p "$backup_root"
opencode_service_source=""

for relative_path in "${paths[@]}"; do
  target="$HOME/$relative_path"
  [[ -L "$target" ]] || continue

  if [[ "$relative_path" == ".config/opencode" ]]; then
    source_dir="$(cd "$HOME/.config" && cd "$(readlink opencode)" && pwd)"
    if [[ -f "$source_dir/service.json" ]]; then
      opencode_service_source="$source_dir/service.json"
    fi
  fi

  backup="$backup_root/$relative_path"
  if [[ -e "$backup" || -L "$backup" ]]; then
    printf 'Backup path already exists: %s\n' "$backup" >&2
    exit 1
  fi
  mkdir -p "$(dirname "$backup")"
  mv "$target" "$backup"
done

if [[ -n "$opencode_service_source" && ! -e "$HOME/.config/opencode/service.json" ]]; then
  mkdir -p "$HOME/.config/opencode"
  mv "$opencode_service_source" "$HOME/.config/opencode/service.json"
fi

printf 'Saved existing dotfile symlinks under %s\n' "$backup_root"
printf 'Home Manager will create managed files on the next activation.\n'
