{ config, lib, pkgs, inputs, ... }:

{

  imports = [
    ./hardware-configuration.nix
    ../../modules/system/network.nix
    ../../modules/system/users.nix
    ../../modules/system/fonts.nix
    ../../modules/system/amd.nix
    ../../modules/system/boot.nix
    ../../modules/system/xserver.nix
    ../../modules/system/substituter.nix
    ../../modules/system/pipewire.nix
  ];

  time.timeZone = "Europe/Rome";
  i18n.defaultLocale = "en_US.UTF-8";
   
  security = {
    rtkit.enable = true;
  };

  # Don't touch this
  system.stateVersion = "23.05";
}
