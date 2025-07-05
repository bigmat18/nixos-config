{ pkgs, ...}:
{
  virtualisation.docker.enable = true;
  virtualisation.docker.enableOnBoot = true;

  hardware.nvidia-container-toolkit.enable = true;

  environment.systemPackages = [
    pkgs.nvidia-container-toolkit
    pkgs.xorg.xhost
  ];
}