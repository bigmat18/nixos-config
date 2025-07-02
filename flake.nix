{
  nixConfig = {
    extra-substituters = [
      "https://cache.soopy.moe"
    ];
    extra-trusted-public-keys = [
      "cache.soopy.moe-1:0RZVsQeR+GOh0VQI9rvnHz55nVXkFardDqfm4+afjPo="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixos-hardware, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      user = "bigmat18";

      mkHome = host: ./hosts/${host}/home.nix;
      mkPkgs = import nixpkgs { inherit system; 
        config = {
          allowUnfree = true;
          cudaSupport = true;
          pulseaudio = true;
        }; 
      };

      nixpkgsConfigModule = {
        nixpkgs.config.allowUnfree = true;
        nixpkgs.config.cudaSupport = true;
        nixpkgs.config.pulseaudio = true;
      };

      mkConfig = host: extraModules: nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          nixpkgsConfigModule
          ./hosts/${host}/configuration.nix
          home-manager.nixosModules.home-manager { 
            home-manager.users.${user} = mkHome host; 
          }
        ] ++ extraModules;
      };

      defaultShell = import ./shells/default-shell.nix { pkgs = mkPkgs; };
      mpiShell = import ./shells/mpi-shell.nix { pkgs = mkPkgs; };
      cudaShell = import ./shells/cuda-shell.nix { pkgs = mkPkgs; };

    in
    {
      nixosConfigurations = {
        macbook2019 = mkConfig "macbook2019" [ nixos-hardware.nixosModules.apple-t2 ];
        desktop = mkConfig "desktop" [ ];
      };

      homeConfigurations = {
        "debian" = home-manager.lib.homeManagerConfiguration {
          pkgs = mkPkgs;
          modules = [ mkHome "desktop" ];
        };
      };

      devShells.${system} = {
        default = defaultShell;
        mpi = mpiShell;
        cuda = cudaShell;
      };

      nix.settings.allowed-uris = [ "github:" ];
    };
}