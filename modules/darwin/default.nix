{ pkgs, ... }:
{
  imports = [ ./aerospace.nix ];

  nix.package = pkgs.lix;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.hostPlatform = "aarch64-darwin";
  system.stateVersion = 7;

  system.defaults = {
    NSGlobalDomain = {
      AppleInterfaceStyleSwitchesAutomatically = true;
      ApplePressAndHoldEnabled = false;
      AppleShowAllExtensions = true;
      InitialKeyRepeat = 10;
      KeyRepeat = 1;
      "com.apple.swipescrolldirection" = true;
    };

    dock = {
      autohide = true;
      mru-spaces = false;
      show-recents = false;
      tilesize = 58;
    };

    finder = {
      FXPreferredViewStyle = "icnv";
      ShowPathbar = true;
      ShowStatusBar = true;
    };
  };

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = false;
      cleanup = "zap";
      upgrade = false;
    };

    taps = [
      { name = "rjyo/moshi"; trusted = true; }
    ];

    brews = [
      "docker"
      "mole"
      "rjyo/moshi/moshi-hook"
      "tree-sitter-cli"
    ];

    global.autoUpdate = false;
  };

  environment.systemPackages = with pkgs; [
    git
    neovim
    zsh
    zsh-completions
  ];

  programs.zsh.enable = true;
}
