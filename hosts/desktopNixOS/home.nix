{ config, pkgs, inputs, ... }:

{
  imports = [
    ../../stylix.nix
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
      command = "xrandr --output HDMI-0 --rotate inverted --scale 1.25x1.25 &&" +
                "xrandr --output DP-0 --rotate inverted --mode 2560x1440 --rate 180 &&" +
                "xrandr --output DP-0 --left-of HDMI-0";
    }
    {
      command = "blueman-applet";
      always = false;
      notification = false;
    }
    # {
    #   command = "rclone mount iclouddrive: ~/icloud/ --vfs-cache-mode full";
    #   always = false;
    #   notification = false;
    # }
  ];
}