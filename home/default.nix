{ config, pkgs, ... }:

{
  imports = [
    ./i3
    ./i3status
    ./picom
    ./zsh
    ./polybar
  ];

  programs.home-manager.enable = true;
  home.stateVersion = "24.11";
  home.username = "bigmat18";
  home.homeDirectory = "/home/bigmat18";

  home.file = {
    ".xinitrc".source = ../dotfiles/.xinitrc;
    ".bash_profile".source = ../dotfiles/.bash_profile;
    ".zprofile".source = ../dotfiles/.zprofile;
    ".config/rclone/rclone.conf".source = ../dotfiles/rclone/rclone.conf;
  };

  services.i3status.activeModules = [ 
    "volume master"  
    "wireless _first_" 
    "cpu_usage" 
    "memory" 
    "cpu_temperature 0"
    "tztime localdate"
    "tztime localtime"
  ];

  systemd.user.startServices = "sd-switch";
}