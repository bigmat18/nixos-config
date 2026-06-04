{ pkgs, vars, ... }:
let
  connect-tunnel = pkgs.writeShellScriptBin "connect-tunnel" ''
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
      -v $HOME:/home/${vars.username} \
      ubuntu startct
  '';
in 
{
  home.packages = [ connect-tunnel ];

  xdg.desktopEntries.connect-tunnel = {
    name = "Connect Tunnel";
    exec = "connect-tunnel"; 
    terminal = false;
    icon = "utilities-terminal";
  };
}