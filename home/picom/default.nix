{ config, pkgs, lib, ...}:
{
  services.picom = {
    enable = true;
    backend = "glx";
    opacityRules = [
      "85:class_g = 'Alacritty'"
    ];
    vSync = true;
  };
}