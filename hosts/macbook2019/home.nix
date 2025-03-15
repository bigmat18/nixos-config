{ config, pkgs, ... }:

{
  imports = [
    ../../home
  ];

  services.i3.startupCommands = [
    {
      command = "xinput set-prop \"bcm5974\" \"libinput Accel Speed\" 0.7";
    }
    {
      command = "xrandr --output eDP-1 --dpi 144";
    }
  ];
}