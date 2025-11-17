{ config, pkgs, inputs, username, ... }:

{
  programs.firefox = {
    enable = true;
    profiles.${username} = {
      path = "sryda9m2.default";
    };
  };

  textfox = {
    enable = true;
    profile = "${username}";
  };
}