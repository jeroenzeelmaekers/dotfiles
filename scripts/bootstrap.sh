#!/bin/bash
set -euo pipefail

repo_url="https://github.com/jeroenzeelmaekers/dotfiles.git"
repo_dir="$HOME/github/jeroenzeelmaekers/dotfiles"
brew_installer=""
nix_installer=""

cleanup() {
  [[ -z "$brew_installer" ]] || /bin/rm -f "$brew_installer"
  [[ -z "$nix_installer" ]] || /bin/rm -f "$nix_installer"
}
trap cleanup EXIT

usage() {
  printf 'Usage: %s <personal|work>\n' "${0##*/}" >&2
  exit 2
}

[[ $# -eq 1 ]] || usage
profile="$1"

case "$profile" in
  personal)
    expected_user="jeroen"
    ;;
  work)
    expected_user="jeroen.zeelmaekers"
    ;;
  *)
    usage
    ;;
esac

if [[ "$(uname -s)" != Darwin || "$(uname -m)" != arm64 ]]; then
  printf 'This bootstrap supports Apple Silicon Macs running macOS.\n' >&2
  exit 1
fi

current_user="$(id -un)"
if [[ "$current_user" != "$expected_user" ]]; then
  printf 'The %s profile is configured for user %s, but this Mac is logged in as %s.\n' \
    "$profile" "$expected_user" "$current_user" >&2
  printf 'Update the username and home directory in hosts/%s.nix before continuing.\n' \
    "$profile" >&2
  exit 1
fi

if [[ ! -r /dev/tty ]]; then
  printf 'Run this script from an interactive terminal so you can approve system changes.\n' >&2
  exit 1
fi

printf 'The %s profile uses Homebrew cleanup mode "zap". Activation can remove Homebrew packages and cask data not listed in the configuration.\n' \
  "$profile"
printf 'Type "activate" to continue: '
IFS= read -r answer </dev/tty
if [[ "$answer" != activate ]]; then
  printf 'Cancelled.\n'
  exit 1
fi

if ! /usr/bin/xcode-select -p >/dev/null 2>&1; then
  printf 'Installing the Xcode Command Line Tools. Complete the macOS installer if it opens.\n'
  /usr/bin/xcode-select --install || true
  for ((attempt = 0; attempt < 360; attempt++)); do
    /usr/bin/xcode-select -p >/dev/null 2>&1 && break
    sleep 5
  done
  if ! /usr/bin/xcode-select -p >/dev/null 2>&1; then
    printf 'The Command Line Tools are not available yet. Finish the installer and rerun this command.\n' >&2
    exit 1
  fi
fi

if ! command -v brew >/dev/null 2>&1 && [[ ! -x /opt/homebrew/bin/brew ]]; then
  printf 'Installing Homebrew.\n'
  brew_installer="$(/usr/bin/mktemp -t dotfiles-brew.XXXXXX)"
  /usr/bin/curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh -o "$brew_installer"
  NONINTERACTIVE=1 /bin/bash "$brew_installer"
fi

if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if ! command -v brew >/dev/null 2>&1; then
  printf 'Homebrew installation completed, but brew is not on PATH.\n' >&2
  exit 1
fi

if [[ -r /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
  # shellcheck disable=SC1091
  . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
elif [[ -r "$HOME/.nix-profile/etc/profile.d/nix.sh" ]]; then
  # shellcheck disable=SC1091
  . "$HOME/.nix-profile/etc/profile.d/nix.sh"
fi

if ! command -v nix >/dev/null 2>&1; then
  printf 'Installing the multi-user Nix daemon.\n'
  nix_installer="$(/usr/bin/mktemp -t dotfiles-nix.XXXXXX)"
  /usr/bin/curl -fsSL https://nixos.org/nix/install -o "$nix_installer"
  NIX_INSTALLER_YES=1 /bin/sh "$nix_installer" --daemon
fi

if [[ -r /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
  # shellcheck disable=SC1091
  . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi

if ! command -v nix >/dev/null 2>&1; then
  printf 'Nix installation completed, but nix is not on PATH. Open a new terminal and rerun this command.\n' >&2
  exit 1
fi
nix_bin="$(command -v nix)"

mkdir -p "$(dirname "$repo_dir")"
if [[ -e "$repo_dir" ]]; then
  if ! git -C "$repo_dir" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    printf 'Expected a Git checkout at %s, but that path already exists.\n' "$repo_dir" >&2
    exit 1
  fi

  origin="$(git -C "$repo_dir" remote get-url origin)"
  case "$origin" in
    https://github.com/jeroenzeelmaekers/dotfiles.git|git@github.com:jeroenzeelmaekers/dotfiles.git)
      ;;
    *)
      printf 'The existing checkout at %s has an unexpected origin: %s\n' "$repo_dir" "$origin" >&2
      exit 1
      ;;
  esac

  printf 'Using the existing checkout at %s without changing it.\n' "$repo_dir"
else
  printf 'Cloning the Nix configuration into %s.\n' "$repo_dir"
  git clone "$repo_url" "$repo_dir"
fi

printf 'Applying the %s Nix configuration. This may take several minutes.\n' "$profile"
NIX_CONFIG='experimental-features = nix-command flakes' \
  nix build --no-link "$repo_dir#darwinConfigurations.$profile.system"
bash "$repo_dir/scripts/prepare-home-manager.sh"
sudo env NIX_CONFIG='experimental-features = nix-command flakes' \
  "$nix_bin" run github:nix-darwin/nix-darwin/master#darwin-rebuild -- \
  switch --flake "$repo_dir#$profile"

printf 'Nix configuration applied.\n'
