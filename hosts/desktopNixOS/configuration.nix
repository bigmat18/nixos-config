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
    ../../modules/system/game.nix
    ../../modules/system/vm.nix
  ];

  time.timeZone = "Europe/Rome";
  i18n.defaultLocale = "en_US.UTF-8";

  # Used for flatpak
  # xdg.portal = {
  #   enable = true;
  #   extraPortals = with pkgs; [
  #     xdg-desktop-portal-gtk
  #   ];
  # };

  security = {
    rtkit.enable = true;   # For audio purposes
    polkit.enable = true;  # Used to control system preferences
  };

  services = {
    dbus.enable = true;
    gvfs.enable = true;
    # flatpak.enable = true;
  };

  programs = {
    thunar.enable = true;
    dconf.enable = true;
    nix-ld.enable = true;
    zsh.enable = true; # To fix rebuild bug
    java = {
      enable = true;
      package = pkgs.openjdk;
    };
  };

  environment.systemPackages = with pkgs; [
    lxsession
    python3
  ];

  services.tailscale.enable = true;

  # Don't touch this
  system.stateVersion = "23.05";
}