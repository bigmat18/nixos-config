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
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;

    vars = import ./vars.nix;
    systems = [
      "x86_64-linux"
      "aarch64-darwin"
    ];
    forAllSystems = nixpkgs.lib.getAttrs systems;

    mkNixOSConfig = path: nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs outputs vars self; };
      modules = [ path ];
    };

    mkDarwinConfig = path: nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs outputs vars self; };
      modules = [ path ];
    };

    mkHomeConfig = path: home-manager.lib.homeManagerConfiguration {
      specialArgs = { inherit inputs outputs vars self; };
      modules = [ path ];
    };

    in {

      overlays = let
        path = ./packages;
        files = builtins.attrNames (builtins.readDir path);
        nixFiles = builtins.filter (n: builtins.match ".*\\.nix" n != null) files;
      in {      
        automaticPackages = final: prev: {
          myPkgs = builtins.listToAttrs (map (fileName: {
            name = builtins.replaceStrings [".nix"] [""] fileName;
            value = prev.callPackage (path + "/${fileName}") { inherit vars; };
          }) nixFiles);
        };
      };

      homeConfigurations = {};

      darwinConfigurations = {};

      nixosConfigurations = {
        oryx = mkNixOSConfig ./hosts/oryx/configuration.nix;
      };

    };
}