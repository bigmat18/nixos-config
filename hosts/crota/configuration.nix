{ 
  inputs,
  outputs,
  vars,
  pkgs,
  ... 
}:
let 
  username = "giuntoni";
in 
{
  imports = [
    inputs.home-manager.darwinModules.home-manager
    inputs.stylix.darwinModules.stylix
    ../../stylix.nix

    ../../modules/common/fonts
    ../../modules/common/nix
    ../../modules/common/nix-scripts

    ../../modules/darwin/homebrew
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs vars; };
    useGlobalPkgs = true;
    useUserPackages = true;

    users.${username} = { 
      imports = [
        ../../home/nvim
        ../../home/tmux
        ../../home/zsh
        ../../home/git
        ../../home/alacritty
        ../../home/fastfetch
      ];

      home.stateVersion = "24.11";
    };
  };

  users.users.${username} = {
    name = "${username}";
    home = "/Users/${username}";
  };

  system.stateVersion = 4;
  nixpkgs.hostPlatform = "aarch64-darwin";
  system.primaryUser = "${username}";
} 