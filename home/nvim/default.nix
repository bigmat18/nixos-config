{ config, pkgs, lib, ...}:
{
  programs.neovim = {
    enable = true;
  };

  home.file.".config/nvim".source = ./nvim-config;

}