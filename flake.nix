{
  nixConfig = {
    extra-substituters = [ "https://cache.soopy.moe" ];
    extra-trusted-public-keys = [ "cache.soopy.moe-1:0RZVsQeR+GOh0VQI9rvnHz55nVXkFardDqfm4+afjPo=" ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix/release-25.11";
    textfox.url = "github:adriankarlen/textfox";
  };

  outputs = { self, nixpkgs, nixos-hardware, home-manager, ... }@inputs:
    let
      username = "bigmat18";
      system = "x86_64-linux";

      customPkgs = system: import nixpkgs { 
        inherit system; 
        config = {
          allowUnfree = true;
          cudaSupport = true;
          pulseaudio = true;
          permittedInsecurePackages = [ "qtwebengine-5.15.19" ];
        }; 
      };

      nixosConfig = host: system: extraModules: 
        nixpkgs.lib.nixosSystem {
          specialArgs = { inherit system inputs username; };
          modules = [
            { nixpkgs.pkgs = customPkgs system; }
            ./hosts/${host}/configuration.nix
            
            home-manager.nixosModules.home-manager { 
              home-manager.extraSpecialArgs = { inherit username inputs; };
              home-manager.users.${username} = {
                imports = [ ./hosts/${host}/home.nix ];
              }; 
            }
          ] ++ extraModules;
        };

      homeConfig = host: system: extraModules: 
        home-manager.lib.homeManagerConfiguration {
          pkgs = customPkgs system;
          extraSpecialArgs = { inherit inputs system username; };
          modules = [
            ./hosts/${host}/home.nix
          ] ++ extraModules;
        };

    in
    {
      nixosConfigurations = {
        desktop = nixosConfig "desktop" "x86_64-linux" [
          inputs.stylix.nixosModules.stylix
          ./stylix.nix
        ];
      };

      homeConfigurations = {
        qualcomm = homeConfig "qualcomm" "aarch64-linux" [
          inputs.stylix.homeManagerModules.stylix
        ];
      };

      devShells.${system} = {
        graphics = import ./shells/graphics-shell.nix { pkgs = customPkgs system; };
        mpi = import ./shells/mpi-shell.nix { pkgs = customPkgs system; };
        cuda = import ./shells/cuda-shell.nix { pkgs = customPkgs system; };
        js = import ./shells/js-shell.nix { pkgs = customPkgs system; };
        py = import ./shells/py-shell.nix { pkgs = customPkgs system; };
      };

    };
}