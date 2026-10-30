{ ... }:
{
  system.primaryUser = "jeroen.zeelmaekers";
  users.users."jeroen.zeelmaekers".home = "/Users/jeroen.zeelmaekers";

  services.aerospace.settings.workspace-to-monitor-force-assignment = {
    misc_2 = 2;
    misc_3 = 2;
  };

  homebrew.casks = [
    "1password"
    "ghostty"
    "bartender"
    "cleanshot"
    "codexbar"
    "figma"
    "istat-menus"
    "pixelsnap"
    "rapidapi"
    "tableplus"
    "spotify"
    "abue-ammar/tinycast/tinycast"
    "openlogi"
  ];

  homebrew.taps = [
    { name = "steipete/tap"; trusted = true; }
    { name = "anomalyco/tap"; trusted = true; }
    { name = "abue-ammar/tinycast"; trusted = true; }
  ];

  homebrew.brews = [
    "anomalyco/tap/opencode-v2"
    "herdr"
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

    users."jeroen.zeelmaekers" = {
      imports = [
        ../modules/home
        ../profiles/work.nix
      ];

      home = {
        username = "jeroen.zeelmaekers";
        homeDirectory = "/Users/jeroen.zeelmaekers";
        stateVersion = "26.05";
      };
    };
  };
}
