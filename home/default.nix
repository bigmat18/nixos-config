{ config, pkgs, inputs, ... }:

{
  imports = [
    ./i3
    ./i3status
    ./picom
    ./zsh
    ./polybar
    ./nvim
    ./tmux
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

  systemd.user.startServices = "sd-switch";
}