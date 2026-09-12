{ pkgs, vars, ... }:
let
  ubuntu = pkgs.writeShellScriptBin "ubuntu" ''
    export DISPLAY="''${DISPLAY:-:0}"
    ${pkgs.xhost}/bin/xhost +SI:localuser:root >/dev/null 2>&1 || true

    DOCKER_ARGS=(
      --rm
      --hostname nixbtw
      --device nvidia.com/gpu=all
      --device /dev/net/tun
      -e DISPLAY="$DISPLAY"
      -v /tmp/.X11-unix:/tmp/.X11-unix:ro
      "''${XAUTH_MOUNT[@]}"
      --cap-add=SYS_ADMIN
      --cap-add=NET_ADMIN
      --security-opt seccomp=unconfined
      --network=host
      -v "$HOME/.sonicwall:/root/.sonicwall"
      -v "$HOME:/home/${vars.username}"
    )

    CMD="''${1:-/bin/bash}"
    exec docker run "''${DOCKER_ARGS[@]}" ubuntu "$CMD"
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
  environment.systemPackages = with pkgs; [
    ubuntu
    connect-tunnel
    xhost
  ];
}
