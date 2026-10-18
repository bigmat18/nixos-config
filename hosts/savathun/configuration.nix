{
  inputs,
  outputs,
  vars,
  pkgs,
  lib,
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
    ../../modules/darwin/yabai
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs vars; };
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";

    users.${vars.username} = {
      targets.darwin.copyApps.enable = true;
      imports = [
        ../../home/nvim
        ../../home/tmux
        ../../home/zsh
        ../../home/git
        ../../home/alacritty
        ../../home/fastfetch
        ../../home/firefox
        ../../home/yazi
        ../../home/fastfetch
      ];

      home.stateVersion = "26.05";
    };
  };

  system.defaults.finder = {
    CreateDesktop = false;
  };

  system.defaults = {
    dock = {
      autohide = true;
      autohide-delay = 1000.0;
      autohide-time-modifier = 0.0;
      orientation = "bottom";
      show-process-indicators = false;
      show-recents = false;
      static-only = true;
    };
  };

  users.users.${vars.username} = {
    name = "${vars.username}";
    home = "/Users/${vars.username}";
  };

  system.stateVersion = 4;
  nixpkgs.hostPlatform = "x86_64-darwin";
  system.primaryUser = "${vars.username}";
}
