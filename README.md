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
scripts/            First-activation migration helper
```

Update the username and home directory in `hosts/work.nix` if they differ on
the work Mac.

## Use

Install Nix with flakes enabled and install Homebrew. Make sure the flake files
are tracked by Git before running Nix commands.

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
