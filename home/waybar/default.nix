{ config, pkgs, lib, vars, ... }:
{
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        
        modules-left = [ "sway/workspaces" ];
        modules-center = [  ];
        modules-right = [
          "clock"
          "pulseaudio"
          "network"
          "memory"
          "cpu"
          "temperature"
          "battery"
          "tray"
        ];

        "sway/workspaces" = {
          disable-scroll = true;
          all-outputs = false;
          format = "{name}";
        };

        "clock" = {
          format = "{:%A %d/%m/%Y %H:%M:%S}";
          interval = 1;
        };

        "pulseaudio" = {
          format = "VOL {volume}%";
          format-muted = "VOL muted";
          on-click = "pavucontrol";
        };

        "network" = {
          format-wifi = "{signaldBm}dBm {essid}";
          format-ethernet = "ETH {ipaddr}";
          format-disconnected = "W: down";
        };

        "memory" = {
          interval = 5;
          format = "Porn Folder: {used:0.1f}GiB";
        };

        "cpu" = {
          interval = 5;
          format = "Body Fat: {usage}%";
        };

        "temperature" = {
          interval = 5;
          critical-threshold = 80;
          format = "Your Mom Temp: {temperatureC}°C";
        };

        "battery" = {
          states = {
            warning = 20;
            critical = 10;
          };
          format = "{icon} {capacity}% {time}";
          format-icons = ["BAT" "BAT" "BAT"];
          format-charging = "CHR {capacity}%";
          format-plugged = "FULL {capacity}%";
        };

        "tray" = {
          spacing = 8;
        };
      };
    };

    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: "DejaVu Sans Mono", monospace;
        font-size: 13px;
      }

      window#waybar {
        background-color: ${vars.colorscheme.base00};
        color: ${vars.colorscheme.base04};
        min-height: 32px;
      }

      #workspaces button {
        padding: 4px 14px;
        background-color: transparent;
        color: ${vars.colorscheme.base04};
        border-bottom: 2px solid transparent;
      }

      #workspaces button.active {
        background-color: ${vars.colorscheme.base00};
        color: ${vars.colorscheme.base0A};
        border-bottom: 2px solid ${vars.colorscheme.base04};
      }

      #workspaces button.urgent {
        background-color: ${vars.colorscheme.base08};
        color: ${vars.colorscheme.base00};
      }

      /* Orologio: Niente bordi, solo padding */
      #clock {
        padding: 4px 16px;
        color: ${vars.colorscheme.base04};
      }

      /* Moduli a destra: Separatore Gruvbox */
      #battery,
      #cpu,
      #memory,
      #temperature,
      #network,
      #pulseaudio,
      #tray {
        padding: 4px 16px;
        color: ${vars.colorscheme.base04};
        border-left: 1px solid ${vars.colorscheme.base04};
      }
    '';
  };
}
