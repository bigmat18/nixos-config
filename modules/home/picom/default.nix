{ config, pkgs, lib, ...}:
{
  home.packages = [ pkgs.picom ];

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