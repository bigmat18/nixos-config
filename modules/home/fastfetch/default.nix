{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.fastfetch
    pkgs.chafa
  ];

  home.file.".config/fastfetch/config.jsonc".source = ./config.jsonc;
  home.file.".config/fastfetch/logo.webp".source = ./giphy.webp;
  home.file.".config/fastfetch/ascii.txt".source = ./cat.txt;

}