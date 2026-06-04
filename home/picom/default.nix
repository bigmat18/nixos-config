{ config, pkgs, lib, ...}:
{
  home.packages = [ pkgs.picom ];

  services.picom = {
    enable = true;
    backend = "glx";
    opacityRules = [
      "80:class_g = 'Alacritty'"
      "90:class_g = 'Code'"
      "80:class_g = 'obsidian'"
    ];
    vSync = true;
    shadow = true;

    settings = {
      blur-method = "dual_kawase";
      blur-strength = 7;
      blur-background = true;
      blur-background-frame = true;
      blur-background-fixed = true;
      blur-background-exclude = [
        "window_type = 'dock'"
        "window_type = 'desktop'"
        "class_g = 'Conky'"
        "class_g = 'Polybar'"
      ];
    };
  };
}