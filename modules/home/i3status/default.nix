{ config, pkgs, lib, ... }:

with lib;

let
  gruvboxColors = {
    bg           = "#282828";  # Background color
    fg           = "#ebdbb2";  # Foreground color
    bg_inactive  = "#3c3836";  # Inactive background color
    gray         = "#928374";  # Gray color
    dark          = "#1d2021";  # Dark color
    blue          = "#458588";  # Blue color
    yellow        = "#d79921";  # Yellow color
    red           = "#cc241d";  # Red color
    green         = "#8ec07c";  # Green color
  };

  modulesDefinition = {
    "volume master" = { settings = { format = "VOL %volume"; format_muted = "VOL muted"; device = "default"; mixer = "Master"; mixer_idx = 0; }; };
    "wireless _first_" = { settings = { format_up = "%quality %essid"; format_down = "W: down"; }; };
    "disk /" = { settings = { format = "%avail"; }; };
    "memory" = { settings = { format = "Porn Folder: %used"; }; };
    "cpu_temperature 0" = { settings = { format = "Your Mom Temp: %degrees °C"; }; };
    "battery 0" = { settings = { format = "%status %percentage %remaining"; format_down = ""; status_chr = "CHR"; status_bat = "BAT"; status_unk = "UNK"; status_full = "FULL"; path = "/sys/class/power_supply/BAT%d/uevent"; low_threshold = 10; }; };
    "tztime localtime" = { settings = { format = "%A %d/%m/%Y %H:%M:%S"; }; };
    "disk /home" = { settings = { format = "%avail"; }; };
    "cpu_usage" = { settings = { format = "Body Fat: %usage"; }; };
    "load" = { settings = { format = "Your Mom Temp: custom_tmp"; }; };
  };

  modules = builtins.listToAttrs (builtins.genList (i:
    let name = builtins.elemAt config.services.i3status.activeModules i; in {
      name = name;
      value = modulesDefinition.${name} // {
        enable = true;
        position = i;
      };
    }
  ) (builtins.length config.services.i3status.activeModules));

in
{

  options = {
    services.i3status.activeModules = mkOption {
      type = types.listOf types.str;
      default = [];
      description = "Lista dei moduli attivi in i3status.";
    };
    services.i3status.useAlternativeStatusCommand = mkOption {
      type = types.bool;
      default = false;
      description = "Usa un command alternativo al posto di i3status.";
    };
  };

  config = {
    home.packages = with pkgs; [ i3status lm_sensors ];

    home.file.".config/i3status/cpu_temp.sh" = {
      text = ''
        #!/usr/bin/env bash
        TEMP=$(sensors | awk '/k10temp-pci-00c3/,/^$/' | grep 'Tctl:' | awk '{print $2}')
        echo "$TEMP"
      '';
      executable = true;
    };

    home.file.".config/i3status/i3status-wrapper.sh" = {
      text = ''
        #!/usr/bin/env bash
        i3status | while :
        do
          read line
          custom_output=$(${config.home.homeDirectory}/.config/i3status/cpu_temp.sh)
          line=''${line//custom_tmp/$custom_output}
          echo "$line"
        done
      '';
      executable = true;
    };

    programs.i3status = {
      enable = true;
      enableDefault = false;
      general = {
        output_format = "i3bar";
        colors = false;
        interval = 5;
        color_good = gruvboxColors.green;
        color_degraded = gruvboxColors.blue;
        color_bad = gruvboxColors.red;
        markup = "pango";
      };

      modules = modules;
    };

    xsession.windowManager.i3.config.bars = [
      {
        statusCommand = if config.services.i3status.useAlternativeStatusCommand then "${config.home.homeDirectory}/.config/i3status/i3status-wrapper.sh" else "i3status";     
        position = "top";
        fonts = {
          names = ["DejaVu Sans Mono"];
          size = 10.0;
        };

        colors = {
          background = gruvboxColors.bg;
          statusline = gruvboxColors.fg;
          separator = gruvboxColors.yellow;

          focusedWorkspace = {
            border = gruvboxColors.bg;
            background = gruvboxColors.yellow;
            text = gruvboxColors.bg;
          };

          activeWorkspace = {
            border = gruvboxColors.bg_inactive;
            background = gruvboxColors.bg;
            text = gruvboxColors.yellow;
          };

          inactiveWorkspace = {
            border = gruvboxColors.bg_inactive;
            background = gruvboxColors.dark;
            text = gruvboxColors.gray;
          };

          urgentWorkspace = {
            border = gruvboxColors.red;
            background = gruvboxColors.dark;
            text = gruvboxColors.fg;
          };

          bindingMode = {
            border = gruvboxColors.red;
            background = gruvboxColors.dark;
            text = gruvboxColors.fg;
          };
        };

        extraConfig = ''
          padding 5px 7px
          workspace_min_width 35
          separator_symbol " | "
        '';

        trayOutput = "primary";
        trayPadding = 5;
      }
    ];
  };
}
