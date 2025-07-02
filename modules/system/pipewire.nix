{ config, lib, pkgs, ... }:

{
  services.pipewire = {
    enable = true;

    audio.enable = true;
    pulse.enable = true;
    jack.enable = true;

    alsa = {
      enable = true;
      support32Bit = true;
    };

    wireplumber.enable = true;
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  environment.systemPackages = with pkgs; [
    pulseaudio
    pavucontrol
  ];

  users.users.bigmat18.extraGroups = [ "audio" "jackaudio" ];
}