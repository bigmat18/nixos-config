{ config, pkgs, username, ... }:

{
  imports = [
    ../../modules/home/tmux
    ../../modules/home/nvim
    ../../modules/home/zsh
  ];

  programs.home-manager.enable = true;
  home.stateVersion = "24.11";
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";
}