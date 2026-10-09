{ ... }:
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

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
