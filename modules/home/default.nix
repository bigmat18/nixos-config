{ config, pkgs, colorschema, username, ... }:

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
    ./distrobox
  ];

  programs.home-manager.enable = true;
  home.stateVersion = "24.11";
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";

  home.file = {
    ".xinitrc".source = ../../dotfiles/.xinitrc;
    ".bash_profile".source = ../../dotfiles/.bash_profile;
    ".zprofile".source = ../../dotfiles/.zprofile;
  };

  systemd.user.startServices = "sd-switch";
}