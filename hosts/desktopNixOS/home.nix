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
    "load"
    "tztime localtime"
  ];

  services.i3status.useAlternativeStatusCommand = true;

  services.i3.startupCommands = [
    {
      command = "xrandr --output HDMI-0 &&" +
                "xrandr --output DP-0 --rotate inverted &&" +
                "xrandr --output DP-0 --left-of HDMI-0";
    }
    {
      command = "blueman-applet";
      always = false;
      notification = false;
    }
    {
      command = "rclone mount iclouddrive: ~/icloud/ --vfs-cache-mode full";
      always = false;
      notification = false;
    }
  ];
}