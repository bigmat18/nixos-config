{ pkgs, ...}:
{

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };

  # virtualisation.docker.enable = true;
  # virtualisation.docker.enableOnBoot = true;

  hardware.nvidia-container-toolkit.enable = true;

  environment.systemPackages = with pkgs; [
    nvidia-container-toolkit
    xorg.xhost
    distrobox
    podman
  ];
}