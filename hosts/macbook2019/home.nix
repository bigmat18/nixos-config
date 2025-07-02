{ config, pkgs, ... }:

{
  imports = [
    ../../modules/home
  ];

  services.i3status.activeModules = [ 
    "volume master"  
    "wireless _first_" 
    "cpu_usage" 
    "memory" 
    "cpu_temperature 0"
    "battery 0"
    "tztime localtime"
  ];

  services.i3.startupCommands = [
    {
      command = "xinput set-prop \"bcm5974\" \"libinput Accel Speed\" 0.7";
    }
    {
      command = "xrandr --output eDP-1 --dpi 144";
    }
    {
      command = "xrandr --output DisplayPort-1 --rotate inverted && " +
                "xrandr --output DisplayPort-2 --rotate inverted && " +
                "xrandr --output DisplayPort-5 --rotate inverted && " +
                "xrandr --output DisplayPort-2 --left-of DisplayPort-1 &&" +
                "xrandr --output DisplayPort-5 --left-of DisplayPort-1 &&" +
                "xrandr --output eDP-1 --left-of DisplayPort-2 &&" +
                "xrandr --output eDP-1 --left-of DisplayPort-5";

    }
    {
      command = "xset s off -dpms";
    }
  ];
}