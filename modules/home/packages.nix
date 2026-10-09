{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bat
    btop
    colima
    difftastic
    eza
    fzf
    lazydocker
    lazygit
    mosh
    resvg
    ripgrep
    starship
    yazi
    zoxide
  ];
}
