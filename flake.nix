{
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    nixpkgs-intel = {
      url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";
    };
    
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin-intel = {
      url = "github:LnL7/nix-darwin/nix-darwin-26.05";
      inputs.nixpkgs.follows = "nixpkgs-intel";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nix-darwin,
    ...
  } @ inputs: 
  let
    inherit (self) outputs;

    defaultVars = import ./vars.nix;
    vars = extraVars: defaultVars // extraVars;

    mkNixOSConfig = path: extraVars: nixpkgs.lib.nixosSystem {
      specialArgs = { 
        inherit inputs outputs self; 
        vars = vars extraVars;
      };
      modules = [ path ];
    };

    mkDarwinConfig = path: extraVars: 
    let
      system = extraVars.system or "aarch64-darwin";
      customPkgs = extraVars.pkgsInput or null;
      darwin = extraVars.darwin or nix-darwin;
    in darwin.lib.darwinSystem {
      inherit system;
      specialArgs = { 
        inherit inputs outputs self; 
        vars = vars extraVars;
      };
      modules = [ path ] ++ (if customPkgs != null then [{
          nixpkgs.config = nixpkgs.lib.mkForce {};
          nixpkgs.pkgs = import customPkgs {
            inherit system;
            config.allowUnfree = true;
          };
        }] else []);
    };

    mkHomeConfig = path: extraVars: home-manager.lib.homeManagerConfiguration {
      specialArgs = { 
        inherit inputs outputs self; 
        vars = vars extraVars;
      };
      modules = [ path ];
    };

    in {

      homeConfigurations = {};

      darwinConfigurations = {
        crota = mkDarwinConfig ./hosts/crota/configuration.nix {
          username = "giuntoni";
          configDir = "/Users/giuntoni/Desktop/nixos-config";
        };
        savathun = mkDarwinConfig ./hosts/savathun/configuration.nix {
          username = "matteogiu";
          configDir = "/Users/matteogiu/Desktop/nixos-config";
          pkgsInput = inputs.nixpkgs-intel;
          darwin = inputs.nix-darwin-intel;
          system = "x86_64-darwin";
        };
      };

      nixosConfigurations = {
        oryx = mkNixOSConfig ./hosts/oryx/configuration.nix {};
      };

      overlays = import ./libs/mkOverlays.nix { inherit vars; path = ./packages/overlays; };

      packages = import ./libs/mkBuild.nix { inherit nixpkgs vars; path = ./packages/derivations; };

      devShells = import ./libs/mkBuild.nix { inherit nixpkgs vars; path = ./shells; };

    };
}
