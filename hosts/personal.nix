{ ... }:
{
  system.primaryUser = "jeroen";
  users.users.jeroen.home = "/Users/jeroen";

  programs.nix-plist-manager.options.applications.systemSettings = {
    general.softwareUpdate = {
      automaticallyDownloadNewUpdatesWhenAvailable = true;
      automaticallyInstallApplicationUpdatesFromTheAppStore = true;
      automaticallyInstallMacOSUpdates = true;
      automaticallyInstallSystemDataFilesAndSecurityUpdates = true;
    };

    network.firewall = {
      firewall = true;
      options = {
        automaticallyAllowBuiltInSoftwareToReceiveIncomingConnections = true;
        automaticallyAllowDownloadedSignedSoftwareToReceiveIncomingConnections = true;
        blockAllIncomingConnections = false;
        enableStealthMode = false;
      };
    };

    privacyAndSecurity.analyticsAndImprovements = {
      shareMacAnalytics = false;
      shareWithAppDevelopers = false;
    };
  };

  services.aerospace.settings.workspace-to-monitor-force-assignment = {
    misc_2 = 2;
    misc_3 = 2;
  };

  homebrew.casks = [
    "1password"
    "bartender"
    "cleanshot"
    "codexbar"
    "discord"
    "figma"
    "ghostty"
    "helium-browser"
    "istat-menus"
    "pixelsnap"
    "protonvpn"
    "qmk-toolbox"
    "rapidapi"
    "skim"
    "spotify"
    "tableplus"
    "tailscale-app"
    "android-studio"
    "raycast"
  ];
  homebrew.taps = [
    { name = "qmk/qmk"; trusted = true; }
    { name = "osx-cross/arm"; trusted = true; }
    { name = "osx-cross/avr"; trusted = true; }
    { name = "steipete/tap"; trusted = true; }
    { name = "anomalyco/tap"; trusted = true; }
  ];

  homebrew.brews = [
    "qmk/qmk/qmk"
    "xcodes"
    "anomalyco/tap/opencode-v2"
  ];

  homebrew.masApps = {
    "1Password for Safari" = 1569813296;
    "AdBlock Pro" = 1018301773;
    "Dark Reader for Safari" = 1438243180;
    "Dato" = 1470584107;
    "Vimari" = 1480933944;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "pre-nix";

    users.jeroen = { lib, pkgs, ... }: {
      imports = [
        ../modules/home
        ../profiles/personal.nix
      ];

      home.activation.setDefaultBrowser = lib.hm.dag.entryAfter [ "installPackages" ] ''
        ${pkgs.duti}/bin/duti -s net.imput.helium http all
        ${pkgs.duti}/bin/duti -s net.imput.helium https all
      '';

      home = {
        packages = [ pkgs.duti ];
        username = "jeroen";
        homeDirectory = "/Users/jeroen";
        stateVersion = "26.05";
      };
    };
  };
}
