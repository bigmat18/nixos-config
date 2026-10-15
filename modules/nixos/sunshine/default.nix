{ pkgs, ... }:

let
  turnOffPhysical = pkgs.writeShellScript "turn-off-physical" ''
    export SWAYSOCK=$(ls /run/user/$(id -u)/sway-ipc.*.sock 2>/dev/null | head -n 1)
    if [ -n "$SWAYSOCK" ]; then
      ${pkgs.sway}/bin/swaymsg 'output DP-1 disable; output HDMI-A-1 disable' || true
    fi
  '';

  turnOnPhysical = pkgs.writeShellScript "turn-on-physical" ''
    export SWAYSOCK=$(ls /run/user/$(id -u)/sway-ipc.*.sock 2>/dev/null | head -n 1)
    if [ -n "$SWAYSOCK" ]; then
      ${pkgs.sway}/bin/swaymsg 'output DP-1 enable; output HDMI-A-1 enable' || true
    fi
  '';
in
{
  services.sunshine = {
    enable = true;
    autoStart = true;
    openFirewall = true;

    settings = {
      capture = "wlr";
      output_name = "HEADLESS-1";
    };

    applications = {
      apps = [
        {
          name = "Virtual-Monitor";
          image-path = "desktop.png";
          "prep-cmd" = [
            {
              do = "${turnOffPhysical}";
              undo = "${turnOnPhysical}";
            }
          ];
          exclude-global-prep-cmd = "false";
        }
      ];
    };
  };
}
