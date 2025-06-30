{ config, pkgs, ... }:
{
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  }; 

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      nvidia-vaapi-driver
    ];
  };

  services.xserver.videoDrivers = [ "nvidia" ];
}