{ config, pkgs, ... }:

{
  imports = [
    ../../home
    ../../home/obs-studio
  ];

  services.i3status.activeModules = [ 
    "volume master"  
    "wireless _first_" 
    "cpu_usage" 
    "memory" 
    "load"
    "tztime localtime"
  ];

  services.i3status.useAlternativeStatusCommand = true;

  services.i3.startupCommands = [
    {
      command = "xrandr --output HDMI-0 --rotate inverted &&" +
                "xrandr --output DP-0 --rotate inverted &&" +
                "xrandr --output DP-0 --left-of HDMI-0";
    }
  ];
}