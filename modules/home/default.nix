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
  ];

  xdg.enable = true;

  home.activation.configureSpotlight = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    /usr/bin/defaults -currentHost write com.apple.Spotlight MenuItemHidden -int 1
    /usr/bin/defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 '{enabled = 0;}'
  '';

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
