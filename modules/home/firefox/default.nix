{ config, pkgs, inputs, ... }:

{
  programs.firefox = {
    enable = true;
    profiles.bigmat18 = {
      path = "sryda9m2.default";
    };
  };

  textfox = {
    enable = true;
    profile = "bigmat18";
  };
}