{ 
  inputs,
  outputs,
  vars,
  pkgs,
  ... 
}:
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

    users.${vars.username} = { 
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

  users.users.${vars.username} = {
    name = "${vars.username}";
    home = "/Users/${vars.username}";
  };

  system.stateVersion = 4;
  nixpkgs.hostPlatform = "aarch64-darwin";
  system.primaryUser = "${vars.username}";
} 