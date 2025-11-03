{ config, lib, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    autorun = false;

    layout = "us";
    xkb.variant = "intl";
    xkb.options = "compose:ralt";

    windowManager.i3.enable = true;

    desktopManager = {
      xterm.enable = false;
      xfce = {
        enable = true;
        noDesktop = true;
        enableXfwm = false;
      };
    };

    displayManager = {
      startx.enable = true;
      lightdm.enable = lib.mkForce false;
      defaultSession = "none+i3";
    };

    libinput.enable = true;
  };
}