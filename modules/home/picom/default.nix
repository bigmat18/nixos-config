{ config, pkgs, lib, ...}:
{
  home.packages = [ pkgs.picom ];

  services.picom = {
    enable = true;
    backend = "glx";
    opacityRules = [
      # "80:class_g = 'Alacritty'"
      "80:class_g = 'Code'"
    ];
    vSync = true;
    shadow = true;
  };
}