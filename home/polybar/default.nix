{ config, pkgs, lib, ...}:
let
  selectedPolybarTheme = "blocks";
  polybarThemesDir = ./themes;
  selectedThemeDir = "${polybarThemesDir}/${selectedPolybarTheme}";
in
{

  home.packages = with pkgs; [
    polybarFull
  ];

  xdg.configFile."polybar/${selectedPolybarTheme}" = {
    source = selectedThemeDir;
    recursive = true;
  };
}