{ pkgs, lib, ... }:
{  
  stylix.targets.rofi.enable = false;

  programs.rofi = {
    enable = true;
    plugins = [ pkgs.rofi-calc ];
    # extraConfig = {
    #   show-icons = true;
    # };
    theme = lib.mkForce "gruvbox-dark-soft";
  };
}