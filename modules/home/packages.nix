{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bat
    btop
    cargo
    colima
    difftastic
    eza
    fzf
    jq
    lazydocker
    lazygit
    nodejs
    ruby
    resvg
    ripgrep
    rustc
    starship
    yazi
    worktrunk
    zoxide
  ];
}
