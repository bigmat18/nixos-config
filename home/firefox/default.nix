{ config, pkgs, inputs, vars, ... }:

{
  programs.firefox = {
    enable = true;
    profiles.${vars.username} = {
      path = "sryda9m2.default";
    };
  };
}