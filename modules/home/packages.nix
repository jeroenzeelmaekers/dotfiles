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
    nodejs
    ruby
    resvg
    ripgrep
    starship
    yazi
    zoxide
  ];
}
