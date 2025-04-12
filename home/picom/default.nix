{ config, pkgs, lib, ...}:
{
  services.picom = {
    enable = true;
    backend = "glx";
    opacityRules = [
      "80:class_g = 'Alacritty'"
    ];
    vSync = true;
    shadow = true;
  };
}