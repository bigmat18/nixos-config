{ pkgs, vars, ... }:
{
  networking.networkmanager.enable = true;
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
    };
  };

  services.sunshine = {
    enable = true;
    autoStart = true;
    openFirewall = true;

    settings = {
      capture = "wlr";
      output_name = "HEADLESS-1";
    };

    applications = {
      apps = [
        {
          name = "Desktop";
          image-path = "desktop.png";
        }
      ];
    };
  };

  users.users.${vars.username}.extraGroups = [ "networkmanager" ];
}
