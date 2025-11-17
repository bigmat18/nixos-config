{ config, lib, pkgs, username, ... }:

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

  hardware.pulseaudio.enable = false;
  environment.systemPackages = with pkgs; [
    pulseaudio
    pavucontrol
  ];

  users.users.${username}.extraGroups = [ "audio" "jackaudio"  ];
}