{ ... }:
{
  # Update this account and home directory if the work Mac uses another
  # macOS username before its first activation.
  system.primaryUser = "jeroen.zeelmaekers";
  users.users.jeroen.home = "/Users/jeroen.zeelmaekers";

  homebrew.casks = [
    "1password"
    "ghostty"
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
