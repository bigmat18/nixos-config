{ pkgs, vars, ... }:
let
  ubuntu = pkgs.writeShellScriptBin "ubuntu" ''
    DOCKER_ARGS=(
      --rm -it
      --hostname nixbtw
      --device nvidia.com/gpu=all
      --device /dev/net/tun
      -e DISPLAY=$DISPLAY
      -v /tmp/.X11-unix:/tmp/.X11-unix
      --cap-add=SYS_ADMIN
      --cap-add=NET_ADMIN
      --security-opt seccomp=unconfined
      --network=host
      -v $HOME/.sonicwall:/root/.sonicwall
      -v $HOME:/home/${vars.username}
    )

    # Se viene passato un argomento, usalo come comando, altrimenti bash
    CMD=''${1:-/bin/bash}
    
    xhost +
    docker run "''${DOCKER_ARGS[@]}" ubuntu "$CMD"
  '';

  connect-tunnel = pkgs.makeDesktopItem {
    name = "connect-tunnel";
    desktopName = "Connect Tunnel";
    exec = "${ubuntu}/bin/ubuntu startct"; 
    terminal = false;
    icon = "utilities-terminal";
    categories = [ "Network" ];
  };
in 
{
  environment.systemPackages = [ ubuntu connect-tunnel ];
}