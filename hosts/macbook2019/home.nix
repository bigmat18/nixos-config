{ config, pkgs, ... }:

{
  imports = [
    ../../home
  ];

  services.i3status.activeModules = [ 
    "volume master"  
    "wireless _first_" 
    "cpu_usage" 
    "memory" 
    "cpu_temperature 0"
    "battery 0"
    "tztime localdate"
    "tztime localtime"
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