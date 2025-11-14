{ pkgs, ...}:
{
  networking.networkmanager.enable = true;
  networking.hostName = "nixbtw";

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
  ];

  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = true;
      AllowUsers = null;
      UseDns = true;
      X11Forwarding = true;
      PermitRootLogin = "prohibit-password";
    };
  };

  networking.firewall.allowedTCPPorts = [ 22 443 500 4500 ];
  networking.firewall.trustedInterfaces = [ "virbr0" ];
}