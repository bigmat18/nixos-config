{ config, pkgs, lib, ...}:

with lib;

let 
  cfg = config.services.i3status;

  modulesDefinition = {
    "volume master" = {
      settings = {
        format = "<span color='#b8bb26' size='large'> </span> <span bgcolor='#b8bb26' foreground='black'> %volume </span>";
        format_muted = "<span color='#fb4934'> %volume</span>";
        device = "default";
        mixer = "Master";
        mixer_idx = 0;
      };
    };

    "wireless _first_" = {
      settings = {
        format_up = "<span color='#83a598' size='large'> </span> <span bgcolor='#83a598' foreground='black'>%quality %essid </span>";
        format_down = "<span color='#fb4934'>  Offline</span>";
      };
    };

    "disk /" = {
      settings = {
        format = "<span color='#8ec07c' size='large'> </span> <span bgcolor='#8ec07c' foreground='black'> %avail </span>";
        prefix_type = "custom";
      };
    };

    "memory" = {
      settings = {
        format = "<span color='#d3869b' size='large'> </span> <span bgcolor='#d3869b' foreground='white'> %used </span>";
        threshold_degraded = "10%";
        format_degraded = "MEMORY: %fr";
      };
    };

    "cpu_temperature 0" = {
      settings = {
        format = "<span color='#fb8c00' size='large'>󱠇 </span> <span bgcolor='#fb8c00' foreground='white'> %degrees °C </span>";
        max_threshold = 50;
      };
    };

    "tztime localdate" = {
      settings = {
        format = "<span color='#d79921' size='large'> </span> <span bgcolor='#d79921' foreground='black'> %a %d-%m-%Y </span>";
      };
    };

    "battery 0" = {
      settings = {
        format = "<span color='#8ec07c' size='large'>%status</span> <span bgcolor='#8ec07c' foreground='black'> %percentage </span>";
        status_chr = "⚡  ";
        status_bat = " ";
        status_unk = "? UNK";
        status_full = "󰂄 FULL";
      };
    };

    "tztime localtime" = {
      settings = {
        format = "<span color='#00bfa5' size='large'>  </span><span bgcolor='#00bfa5' foreground='black'> %I:%M %p </span> ";
      };
    };

    "disk /home" = {
      settings = {
        format = "  %avail ";
        prefix_type = "custom";
      };
    };

    "run_watch DHCP" = {
      settings = {
        pidfile = "/var/run/dhclient*.pid";
      };
    };

    "run_watch VPN" = {
      settings = {
        pidfile = "/var/run/vpnc/pid";
      };
    };

    "ethernet eno16777736" = {
      settings = {
        format_up = " %ip ";
        format_down = "  ";
      };
    };

    "cpu_usage" = {
      settings = {
        format = "  %usage ";
      };
    };

    "load" = {
      settings = {
        format = "  %1min ";
        max_threshold = 5;
      };
    };
  };

  modules = builtins.listToAttrs (builtins.genList (i: 
    let name = builtins.elemAt cfg.activeModules i; in {
      name = name;
      value = modulesDefinition.${name} // { 
        enable = true; 
        position = i; 
      };
    }
  ) (builtins.length cfg.activeModules));
in
{
  options = {
    services.i3status.activeModules = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = "Lista dei moduli attivi in i3status.";
    };
  };

  config = {
    programs.i3status = {
      enable = true;
      enableDefault = false;
      general = {
        output_format = "i3bar";
        colors = false;
        interval = 5;
        color_good = "#aaff00";
        color_degraded = "#00dddd";
        color_bad = "#ff8800";
        markup = "pango";
      };

      modules = modules;
    };
  };
}