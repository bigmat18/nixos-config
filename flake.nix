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
      url = "github:LnL7/nix-darwin/nix-darwin-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
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

    mkDarwinConfig = path: extraVars: nix-darwin.lib.darwinSystem {
      specialArgs = { 
        inherit inputs outputs self; 
        vars = vars extraVars;
      };
      modules = [ path ];
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
      };

      nixosConfigurations = {
        oryx = mkNixOSConfig ./hosts/oryx/configuration.nix {};
      };

      overlays = import ./libs/mkOverlays.nix { inherit vars; path = ./packages/overlays; };

      packages = import ./libs/mkBuild.nix { inherit nixpkgs vars; path = ./packages/derivations; };

      devShells = import ./libs/mkBuild.nix { inherit nixpkgs vars; path = ./shells; };

    };
}
