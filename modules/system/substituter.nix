{ config, lib, ... }:

let
  substituters = [
    "https://cache.soopy.moe"
  ];
  trustedPublicKeys = [
    "cache.soopy.moe-1:0RZVsQeR+GOh0VQI9rvnHz55nVXkFardDqfm4+afjPo="
  ];
in
{
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];

    extra-substituters = substituters;
    extra-trusted-public-keys = trustedPublicKeys;

    trusted-substituters = substituters;
  };
}