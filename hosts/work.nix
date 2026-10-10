{ ... }:
{
  system.primaryUser = "jeroen.zeelmaekers";
  users.users.jeroen.home = "/Users/jeroen.zeelmaekers";

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
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "pre-nix";

    users.jeroen = {
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
