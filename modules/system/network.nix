{ pkgs, ...}:
{
  networking.networkmanager.enable = true;
  networking.hostName = "nixbtw";

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
  ];
}