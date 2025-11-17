{ pkgs, username, ...}:
{
  networking.networkmanager.enable = true;
  networking.hostName = "nixbtw";
  networking.firewall.enable = false;

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

  users.users.${username}.extraGroups = [ "networkmanager" ];
}