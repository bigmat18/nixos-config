{ pkgs, ...}:
{
  networking.networkmanager.enable = true;
  networking.hostName = "nixbtw";

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
  ];

  users.users.bigmat18.extraGroups = [ "networkmanager" ];
}