{ pkgs, ... }:
{
  programs.fastfetch = {
    enable = true;
  };

  home.packages = with pkgs; [
    chafa
  ];
}