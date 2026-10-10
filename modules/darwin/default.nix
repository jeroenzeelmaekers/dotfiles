{ lib, pkgs, ... }:
{
  imports = [ ./aerospace.nix ];

  nix.package = pkgs.lix;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.hostPlatform = "aarch64-darwin";
  system.stateVersion = 7;

  programs.nix-plist-manager = {
    enable = true;
    options.applications.systemSettings.lockScreen = {
      loginWindowShows = "List of users";
      messageWhenLocked = "";
      showPasswordHints = false;
      showTheSleepRestartAndShutDownButtons = true;
    };
  };

  system.defaults = {
    NSGlobalDomain = {
      ApplePressAndHoldEnabled = false;
    };

    dock = {
      persistent-apps = [];
      persistent-others = [];
    };

    finder = {
      FXPreferredViewStyle = "icnv";
    };

    loginwindow = {
      HideUserAvatarAndName = true;
    };

  };

  system.activationScripts.postActivation.text = lib.mkAfter ''
    /usr/bin/mdutil -a -i off
  '';

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
