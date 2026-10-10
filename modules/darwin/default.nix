{ lib, pkgs, ... }:
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
      InitialKeyRepeat = 15;
      KeyRepeat = 2;
      "com.apple.swipescrolldirection" = false;
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

    loginwindow = {
      HideUserAvatarAndName = true;
      LoginwindowText = "";
      RestartDisabled = false;
      SHOWFULLNAME = false;
      ShutDownDisabled = false;
      SleepDisabled = false;
    };

    menuExtraClock = {
      IsAnalog = false;
      Show24Hour = true;
      ShowAMPM = false;
      ShowDate = 2;
      ShowDayOfMonth = false;
      ShowDayOfWeek = false;
      ShowSeconds = false;
    };

    CustomSystemPreferences."com.apple.loginwindow".RetriesUntilHint = 0;
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
