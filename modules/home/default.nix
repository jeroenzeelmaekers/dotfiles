{ lib, ... }:
{
  imports = [
    ./packages.nix
    ./shell.nix
    ./git.nix
    ./starship.nix
    ./bat.nix
    ./ghostty.nix
    ./herdr.nix
    ./lazygit.nix
    ./yazi.nix
    ./neovim.nix
    ./opencode.nix
    ./macos-settings.nix
  ];

  xdg.enable = true;

  home.activation.configureSpotlight = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    /usr/bin/defaults -currentHost write com.apple.Spotlight MenuItemHidden -int 1
  '';

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
