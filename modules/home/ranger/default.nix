{ pkgs, ... }:

{
  home.packages = with pkgs; [ ranger ];
  programs.ranger = {
    enable = true;
    extraConfig = ''
      set colorscheme gruvbox-dark-soft
    '';
  };
}