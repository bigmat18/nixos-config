{ config, pkgs, lib, ...}:
let
  selectedPolybarTheme = "blocks";
  polybarThemesDir = ./polybar-themes;
  selectedThemeDir = "${polybarThemesDir}/${selectedPolybarTheme}";
in
{

  home.packages = with pkgs; [
    polybarFull
  ];

  xdg.configFile."polybar" = {
    source = selectedThemeDir;
    recursive = true;
  };
}