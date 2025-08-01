{ config, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    profiles.default = {
      path = "sryda9m2.default";
    };
  };

  textfox = {
    enable = true;
    profile = "default";
  };
}