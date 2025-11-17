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
      command = "xrandr --output HDMI-0 --rotate inverted &&" +
                "xrandr --output DP-0 --rotate inverted --mode 2560x1440 --rate 180 &&" +
                "xrandr --output DP-0 --left-of HDMI-0 &&" +
                "xrandr --output HDMI-0 --dpi 90";
      always = true;
      notification = false;
    }
  ];
}