{
  nixConfig = {
    extra-substituters = [
      "https://cache.soopy.moe"
    ];
    extra-trusted-public-keys = [ "cache.soopy.moe-1:0RZVsQeR+GOh0VQI9rvnHz55nVXkFardDqfm4+afjPo=" ];
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
      nixpkgsUnfree = import nixpkgs {
        system = system;
        config = {
          allowUnfree = true;
        };
      };
      pkgs = nixpkgsUnfree;
      formatter = pkgs.nixfmt-rfc-style;

      defaultShell = import ./shells/default-shell.nix { inherit pkgs; };
      cudaShell = import ./shells/cuda-shell.nix { inherit pkgs; };
      mpiShell = import ./shells/mpi-shell.nix { inherit pkgs; };
    in
    {
      nixosConfigurations.macbook2019 = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };

        modules = [
          ./hosts/macbook2019/configuration.nix
          ./system/substituter.nix

          nixos-hardware.nixosModules.apple-t2
          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = { inherit inputs; };

            home-manager.users.bigmat18 =
              (import ./hosts/macbook2019/home.nix { config = {}; pkgs = pkgs; });
          }
        ];
      };

      nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/desktop/configuration.nix
          ./system/substituter.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = { inherit inputs; };

            # Stessa cosa per la configurazione desktop
            home-manager.users.bigmat18 =
              (import ./hosts/desktop/home.nix { config = {}; pkgs = pkgs; });
          }
        ];
      };  

      nix.settings.allowed-uris = [ "github:" ];
      devShells.${system} = {
          default = defaultShell;
          cuda = cudaShell;
          mpi = mpiShell;
      };
      
    };
}
