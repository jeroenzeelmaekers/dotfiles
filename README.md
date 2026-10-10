# macOS configuration

Nix configuration for two Apple Silicon Macs. It uses nix-darwin for system
settings and Home Manager for user packages and application configuration.

## Layout

```text
flake.nix          Defines the personal and work systems
hosts/             Host-specific settings and applications
profiles/          Personal and work user settings
modules/darwin/    macOS settings and system packages
modules/home/      User packages and application settings
config/            Application configuration files
assets/            Themes, styles, and wallpapers
scripts/            Bootstrap and first-activation migration scripts
```

Update the username and home directory in `hosts/work.nix` if they differ on
the work Mac.

## Install

On an Apple Silicon Mac, open Terminal and run the command for the machine:

```sh
curl -fsSL https://raw.githubusercontent.com/jeroenzeelmaekers/dotfiles/main/scripts/bootstrap.sh | bash -s -- personal
```

Use `work` instead of `personal` on the work Mac. The script installs the Xcode
Command Line Tools, Homebrew, and multi-user Nix if they are missing. It then
clones this repository to `~/github/jeroenzeelmaekers/dotfiles` and activates
the selected nix-darwin configuration. The work profile expects the macOS
username `jeroen.zeelmaekers`; the personal profile expects `jeroen`.

The script asks for confirmation before installation because the configuration
uses Homebrew cleanup mode `zap`, which can remove packages and cask data not
listed in the Nix configuration. It also needs administrator access. The
Command Line Tools installer may open a macOS dialog.

To inspect the script before running it, download it first:

```sh
curl -fsSLO https://raw.githubusercontent.com/jeroenzeelmaekers/dotfiles/main/scripts/bootstrap.sh
less bootstrap.sh
bash bootstrap.sh personal
```

## Manual use

If Nix and Homebrew are already installed, make sure the flake files are
tracked by Git before running Nix commands.

Check and build the personal system:

```sh
nix flake check
nix build .#darwinConfigurations.personal.system
```

On first activation, if existing `~/.config` dotfiles are symlinks into this
repository, run the migration helper after the build:

```sh
./scripts/prepare-home-manager.sh
```

Then activate the system:

```sh
sudo nix run github:nix-darwin/nix-darwin/master#darwin-rebuild -- switch --flake .#personal
```

For later changes, run:

```sh
sudo darwin-rebuild switch --flake .#personal
```

On the work Mac, replace `personal` with `work` in the commands.

## Update inputs

```sh
nix flake update
nix flake check
nix build .#darwinConfigurations.personal.system
sudo darwin-rebuild switch --flake .#personal
```
