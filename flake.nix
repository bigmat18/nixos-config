{
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-25.11";
    };
    
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nix-darwin,
    ...
  } @ inputs: let
    inherit (self) outputs;

    vars = import ./vars.nix;

    mkNixOSConfig = path: nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs outputs vars self; };
      modules = [ path ];
    };

    mkDarwinConfig = path: nix-darwin.lib.darwinSystem {
      specialArgs = { inherit inputs outputs vars self; };
      modules = [ path ];
    };

    mkHomeConfig = path: home-manager.lib.homeManagerConfiguration {
      specialArgs = { inherit inputs outputs vars self; };
      modules = [ path ];
    };

    in {

      homeConfigurations = {};

      darwinConfigurations = {};

      nixosConfigurations = {
        oryx = mkNixOSConfig ./hosts/oryx/configuration.nix;
      };

      overlays = import ./libs/mkOverlays.nix { inherit vars; path = ./packages/overlays; };

      packages = import ./libs/mkBuild.nix { inherit nixpkgs vars; path = ./packages/derivations; };

      devShells = import ./libs/mkBuild.nix { inherit nixpkgs vars; path = ./shells; };

    };
}