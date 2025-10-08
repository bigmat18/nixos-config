{ config, pkgs, ... }:
{
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  }; 

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      nvidia-vaapi-driver
    ];
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  # services.logind.settings.Login = ''
  #   HandleSuspendKey=suspend
  #   HandleLidSwitch=suspend
  #   HandleLidSwitchDocked=ignore
  # '';
}