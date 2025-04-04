{ config, pkgs, ... }:

{
  imports = [
    ../../home
    ../../home/obs-studio
  ];

  services.i3.startupCommands = [
    {
      command = "xrandr --output HDMI-0 --rotate inverted &&" +
                "xrandr --output DP-0 --rotate inverted &&" +
                "xrandr --output DP-0 --left-of HDMI-0";
    }
  ];
}