{ config, pkgs, username, ... }:

{
  imports = [
    ../../modules/home/tmux
    ../../modules/home/tmux
    ../../modules/home/tmux
  ];

  programs.home-manager.enable = true;
  home.stateVersion = "24.11";
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";
}