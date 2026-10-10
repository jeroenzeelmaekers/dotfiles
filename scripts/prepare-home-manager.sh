#!/bin/bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
backup_root=""
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

opencode_service_source=""

for relative_path in "${paths[@]}"; do
  target="$HOME/$relative_path"
  [[ -L "$target" ]] || continue

  link_source="$(readlink "$target")"
  if [[ "$link_source" == /* ]]; then
    source_path="$link_source"
  else
    source_path="$(dirname "$target")/$link_source"
  fi
  source_path="$(cd "$(dirname "$source_path")" && pwd -P)/$(basename "$source_path")"
  case "$source_path" in
    "$repo_root"/*) ;;
    *) continue ;;
  esac

  if [[ "$relative_path" == ".config/opencode" ]]; then
    source_dir="$(dirname "$source_path")"
    if [[ -f "$source_dir/service.json" ]]; then
      opencode_service_source="$source_dir/service.json"
    fi
  fi

  if [[ -z "$backup_root" ]]; then
    backup_root="$HOME/.local/state/dotfiles-migration/$(date +%Y%m%d-%H%M%S)"
    mkdir -p "$backup_root"
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

if [[ -n "$backup_root" ]]; then
  printf 'Saved repository dotfile symlinks under %s\n' "$backup_root"
else
  printf 'No dotfile symlinks into %s needed migration.\n' "$repo_root"
fi
printf 'Home Manager will create managed files on the next activation.\n'
