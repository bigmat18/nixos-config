{ config, pkgs, ... }:

{
  services.dunst = {
    enable = true;
    package = pkgs.dunst;
  };

  home.packages = with pkgs; [ libnotify ];
}