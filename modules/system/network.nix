{ pkgs, ...}:
{
  networking.networkmanager.enable = true;
  networking.hostName = "nixbtw";

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
  ];

  # networking.firewall.allowedTCPPorts = [ 5900 ];
}