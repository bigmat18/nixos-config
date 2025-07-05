{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/system/network.nix
    ../../modules/system/users.nix
    ../../modules/system/fonts.nix
    ../../modules/system/nvidia.nix
    ../../modules/system/boot.nix
    ../../modules/system/xserver.nix
    ../../modules/system/substituter.nix
    ../../modules/system/pipewire.nix
    ../../modules/system/docker.nix
  ];

  time.timeZone = "Europe/Rome";
  i18n.defaultLocale = "it_IT.UTF-8";

  programs.zsh.enable = true; # To fix rebuild bug

  security = {
    rtkit.enable = true;   # For audio purposes
    polkit.enable = true;  # Used to control system preferences
  };

  # Don't touch this
  system.stateVersion = "23.05";
}
