{ pkgs, username, ...}:
{
  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
  };

  environment.systemPackages = with pkgs; [
    nvidia-container-toolkit # NVIDIA runtime/hooks for GPU in containers
    xorg.xhost               # Control X11 access (add/remove allowed hosts)
  ];

  hardware.nvidia-container-toolkit.enable = true;
  users.users.${username}.extraGroups = [ "docker" ];
}