{
  description = "Jeroen's macOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ nix-darwin, home-manager, ... }:
    let
      mkHost = hostModule: nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = { inherit inputs; };
        modules = [
          home-manager.darwinModules.home-manager
          ./modules/darwin
          hostModule
        ];
      };
    in
    {
      darwinConfigurations = {
        personal = mkHost ./hosts/personal.nix;
        work = mkHost ./hosts/work.nix;
      };
    };
}
