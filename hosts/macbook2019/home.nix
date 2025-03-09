{ config, pkgs, ... }:

{
  home.username = "bigmat18";
  home.homeDirectory = "/home/bigmat18";

  home.stateVersion = "24.11"; # Please read the comment before changing.

  home.packages = [
  ];

  home.file = {
    ".config/i3/config".source = ../../dotfiles/i3/config;
    ".xinitrc".source = ../../dotfiles/.xinitrc;
    ".bash_profile".source = ../../dotfiles/.bash_profile;
  };

  home.sessionVariables = {
    EDITOR = "vim";
  };

  programs.home-manager.enable = true;
}
