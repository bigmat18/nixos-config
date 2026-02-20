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
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix/release-25.11";
    textfox.url = "github:adriankarlen/textfox";
  };

  outputs = { self, nixpkgs, nixos-hardware, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      username = "bigmat18";
      home = host: ./hosts/${host}/home.nix;

      pkgs = import nixpkgs { 
        inherit system; 
        config = {
          allowUnfree = true;
          cudaSupport = true;
          pulseaudio = true;

          permittedInsecurePackages = [
            "qtwebengine-5.15.19"
          ];
        }; 
      };

      config = host: extraModules: nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs username; };
        modules = [
          { nixpkgs.pkgs = pkgs; }

          ./stylix.nix
          ./hosts/${host}/configuration.nix

          inputs.stylix.nixosModules.stylix
          home-manager.nixosModules.home-manager { 
            home-manager.extraSpecialArgs = { inherit username; };
            home-manager.users.${username} = {
              imports = [
                (home host)
                inputs.textfox.homeManagerModules.default
              ];
            }; 
          }
        ] ++ extraModules;
      };

      graphicsShell = import ./shells/graphics-shell.nix { pkgs = pkgs; };
      mpiShell = import ./shells/mpi-shell.nix { pkgs = pkgs; };
      cudaShell = import ./shells/cuda-shell.nix { pkgs = pkgs; };
      jsShell = import ./shells/js-shell.nix { pkgs = pkgs; };
      pyShell = import ./shells/py-shell.nix { pkgs = pkgs; };

    in
    {
      nixosConfigurations = {
        macbook2019 = config "macbook2019" [ nixos-hardware.nixosModules.apple-t2 ];
        desktopNixOS = config "desktopNixOS" [];
      };

      # homeConfigurations = {
      #   desktopLinux = home-manager.lib.homeManagerConfiguration {
      #     pkgs = pkgs;
      #     extraSpecialArgs = { inherit inputs system username; };
      #     modules = [
      #       nixpkgsConfigModule
      #       ./stylix.nix
      #       (home "desktopLinux")
      #       inputs.stylix.homeManagerModules.stylix
      #       inputs.textfox.homeManagerModules.default
      #     ];
      #   };
      # };

      devShells.${system} = {
        graphics = graphicsShell;
        mpi = mpiShell;
        cuda = cudaShell;
        js = jsShell;
        py = pyShell;
      };

      nix.settings.allowed-uris = [ "github:" ];
    };
}