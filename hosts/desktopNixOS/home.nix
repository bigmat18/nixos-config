{ config, pkgs, inputs, ... }:
let
    ubuntu-startct-script = pkgs.writeShellScript "ubuntu-startct-wrapper" ''
      xhost +
      docker run --rm \
        --hostname nixbtw \
        --device nvidia.com/gpu=all \
        --device /dev/net/tun \
        -e DISPLAY=$DISPLAY \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        --cap-add=SYS_ADMIN \
        --cap-add=NET_ADMIN \
        --security-opt seccomp=unconfined \
        --network=host \
        -v $HOME/.sonicwall:/root/.sonicwall \
        -v /home/bigmat18:/home/bigmat18 \
        ubuntu startct
    '';
  in {
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

  xdg.desktopEntries.connect-tunnel = {
    name = "connect-tunnel";
    genericName = "connect-tunnel";
    comment = "Exec \"connect-tunnel\"";
    categories = [ "Utility" ];
    exec = "${ubuntu-startct-script}";
    terminal = false;
    icon = "utilities-terminal";
  };

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

  # services.i3.startupCommands = [
  #   {
  #     command = "xrandr --output HDMI-0 --rate 144 --rotate normal";
  #     always = true;
  #     notification = false;
  #   }
  # ];
}