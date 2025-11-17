{ pkgs, lib, ... }:
{  
  stylix.targets.rofi.enable = false;

  programs.rofi = {
    enable = true;
    font = "Droid Sans Mono 10";
    plugins = [ pkgs.rofi-calc ];
    theme = lib.mkForce "gruvbox-dark-soft";
  };
}