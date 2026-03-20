{ config, pkgs, inputs, username, ... }:
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
    ../../modules/home/i3
    ../../modules/home/i3status
    ../../modules/home/picom
    ../../modules/home/zsh
    ../../modules/home/nvim
    ../../modules/home/tmux
    ../../modules/home/rofi
    ../../modules/home/git
    ../../modules/home/yazi
    ../../modules/home/zathura
    ../../modules/home/fastfetch
    ../../modules/home/firefox
    ../../modules/home/alacritty
    ../../modules/home/obs-studio
    ../../modules/home/dust
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
  
  programs.home-manager.enable = true;
  home.stateVersion = "24.11";
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";

  home.file = {
    ".xinitrc".source = ../../dotfiles/.xinitrc;
    ".bash_profile".source = ../../dotfiles/.bash_profile;
    ".zprofile".source = ../../dotfiles/.zprofile;
  };

  systemd.user.startServices = "sd-switch";
}