{ config, pkgs, ... }:
{
  homebrew = {
    enable = true;
    
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;

    taps = [];

    brews = [];

    casks = [
      "alacritty"
    ];
  };
}