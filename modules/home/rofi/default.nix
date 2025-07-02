{ pkgs, ... }:
{
  # home.packages = [ pkgs.rofi ];
  
  programs.rofi = {
    enable = true;
    plugins = [ pkgs.rofi-calc ];
    theme = "gruvbox-dark";
  };
}