{ config, pkgs, colorschema, ... }:

{
  imports = [
    ./i3
    ./i3status
    ./picom
    ./zsh
    ./nvim
    ./tmux
    ./rofi
    ./git
    ./yazi
    ./zathura
    ./fastfetch
    ./firefox
    ./alacritty
    ./obs-studio
    ./dust
  ];

  programs.home-manager.enable = true;
  home.stateVersion = "24.11";
  home.username = "bigmat18";
  home.homeDirectory = "/home/bigmat18";

  home.file = {
    ".xinitrc".source = ../../dotfiles/.xinitrc;
    ".bash_profile".source = ../../dotfiles/.bash_profile;
    ".zprofile".source = ../../dotfiles/.zprofile;
  };

  systemd.user.startServices = "sd-switch";
}