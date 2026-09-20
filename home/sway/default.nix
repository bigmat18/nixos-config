{
  config,
  pkgs,
  lib,
  vars,
  ...
}:

with lib;

let
  modifier = "Mod4";
  gruvbox = vars.colorscheme;
in
{
  options = {
    services.sway.startupCommands = mkOption {
      type = types.listOf (
        types.submodule {
          options = {
            command = mkOption { type = types.str; };
            always = mkOption {
              type = types.bool;
              default = false;
            };
          };
        }
      );
      default = [ ];
      description = "List of commands to run on startup";
    };
  };

  config = {
    home.packages = with pkgs; [
      # Screenshots tools
      grim
      slurp

      # Brightness tools
      jq
      wl-gammarelay-rs
    ];

    wayland.windowManager.sway = {
      enable = true;
      wrapperFeatures.gtk = true;

      extraConfig = ''
        default_floating_border pixel 2
        for_window [app_id="FloatingRanger"] floating enable, resize set 50 ppt 50 ppt, move position center
        for_window [class="FloatingRanger"] floating enable, resize set 50 ppt 50 ppt, move position center
      '';

      config = {
        inherit modifier;
        floating.modifier = modifier;
        floating.border = 2;
        floating.titlebar = false;

        workspaceOutputAssign = [
          {
            workspace = "1";
            output = "DP-1";
          }
        ];

        output = {
          "DP-1" = {
            resolution = "2560x1440@180Hz";
            position = "0,0";
            scale = "1";
            transform = "180";
            bg = "${config.stylix.image} fill";
          };
          "HDMI-A-1" = {
            resolution = "1920x1080@60Hz";
            position = "2560,0";
            scale = "1";
            transform = "180";
            bg = "${config.stylix.image} fill";
          };
        };

        input = {
          "*" = {
            xkb_layout = "us";
            xkb_variant = "intl";
            xkb_options = "compose:ralt";
          };
        };

        keybindings = {
          "${modifier}+Return" = "exec alacritty";
          "${modifier}+Shift+Return" = "exec alacritty -e distrobox-enter --root debian-box";
          "${modifier}+Shift+s" = "exec grim -g \"$(slurp)\" - | wl-copy -t image/png";

          "${modifier}+Shift+q" = "kill";
          "${modifier}+d" = "exec rofi -show drun";
          "${modifier}+b" = "exec firefox";
          "${modifier}+c" = "exec rofi -show calc -modi calc -no-show-match -no-sort";
          "${modifier}+Shift+f" = "exec alacritty --class FloatingRanger -e yazi";

          "${modifier}+Shift+c" = "reload";
          "${modifier}+Shift+r" = "restart";
          "${modifier}+Shift+e" =
            "exec swaynag -t warning -m 'Vuoi uscire da Sway?' -B 'Sì, esci' 'swaymsg exit'";

          "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +10%";
          "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -10%";
          "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
          "XF86AudioMicMute" = "exec pactl set-source-mute @DEFAULT_SOURCE@ toggle";

          "XF86MonBrightnessUp" = "exec bash ~/.config/sway/brightness.sh +";
          "XF86MonBrightnessDown" = "exec bash ~/.config/sway/brightness.sh -";

          "${modifier}+1" = "workspace number 1";
          "${modifier}+2" = "workspace number 2";
          "${modifier}+3" = "workspace number 3";
          "${modifier}+4" = "workspace number 4";
          "${modifier}+5" = "workspace number 5";
          "${modifier}+6" = "workspace number 6";
          "${modifier}+7" = "workspace number 7";
          "${modifier}+8" = "workspace number 8";
          "${modifier}+9" = "workspace number 9";
          "${modifier}+0" = "workspace number 10";

          "${modifier}+Shift+1" = "move container to workspace number 1";
          "${modifier}+Shift+2" = "move container to workspace number 2";
          "${modifier}+Shift+3" = "move container to workspace number 3";
          "${modifier}+Shift+4" = "move container to workspace number 4";
          "${modifier}+Shift+5" = "move container to workspace number 5";
          "${modifier}+Shift+6" = "move container to workspace number 6";
          "${modifier}+Shift+7" = "move container to workspace number 7";
          "${modifier}+Shift+8" = "move container to workspace number 8";
          "${modifier}+Shift+9" = "move container to workspace number 9";

          "${modifier}+j" = "focus up";
          "${modifier}+k" = "focus down";
          "${modifier}+l" = "focus right";
          "${modifier}+h" = "focus left";

          "${modifier}+Left" = "focus left";
          "${modifier}+Down" = "focus down";
          "${modifier}+Up" = "focus up";
          "${modifier}+Right" = "focus right";

          "${modifier}+Shift+j" = "move up";
          "${modifier}+Shift+k" = "move down";
          "${modifier}+Shift+l" = "move right";
          "${modifier}+Shift+h" = "move left";

          "${modifier}+Shift+Left" = "move left";
          "${modifier}+Shift+Down" = "move down";
          "${modifier}+Shift+Up" = "move up";
          "${modifier}+Shift+Right" = "move right";

          "${modifier}+n" = "split h";
          "${modifier}+v" = "split v";
          "${modifier}+f" = "fullscreen toggle";

          "${modifier}+s" = "layout stacking";
          "${modifier}+w" = "layout tabbed";
          "${modifier}+e" = "layout toggle split";
          "${modifier}+Shift+space" = "floating toggle";
          "${modifier}+space" = "focus mode_toggle";
          "${modifier}+a" = "focus parent";

          "${modifier}+r" = "mode resize";
          "${modifier}+bar" = "move scratchpad";
          "${modifier}+p" = "scratchpad show";
        };

        modes.resize = {
          "Right" = "resize grow width 5 px or 5 ppt";
          "Up" = "resize shrink height 5 px or 5 ppt";
          "Down" = "resize grow height 5 px or 5 ppt";
          "Left" = "resize shrink width 5 px or 5 ppt";
          "Escape" = "mode default";
          "Return" = "mode default";
        };

        gaps.inner = 6;
        window.border = 2;
        window.titlebar = false;

        colors = lib.mkForce {
          focused = {
            text = gruvbox.base04;
            background = gruvbox.base04;
            border = gruvbox.base04;
            childBorder = gruvbox.base04;
            indicator = gruvbox.base04;
          };
          focusedInactive = {
            text = gruvbox.base04;
            background = gruvbox.base03;
            border = gruvbox.base03;
            childBorder = gruvbox.base03;
            indicator = gruvbox.base03;
          };
          unfocused = {
            text = gruvbox.base04;
            background = gruvbox.base01;
            border = gruvbox.base01;
            childBorder = gruvbox.base01;
            indicator = gruvbox.base01;
          };
          urgent = {
            text = gruvbox.base04;
            background = gruvbox.base08;
            border = gruvbox.base08;
            childBorder = gruvbox.base08;
            indicator = gruvbox.base08;
          };
        };

        bars = [ ];

        startup = [
          {
            command = "dex --autostart --environment sway";
            always = false;
          }
          {
            command = "dunst";
            always = false;
          }
          {
            command = "waybar";
            always = false;
          }
          {
            command = "blueman-applet";
            always = false;
          }
          {
            command = "${pkgs.xrandr}/bin/xrandr --output DP-1 --primary";
            always = true;
          }
          {
            command = "wl-gammarelay-rs";
            always = false;
          }
        ]
        ++ config.services.sway.startupCommands;
      };
    };

    home.file = {
      ".bash_profile".text = ''
        if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
          exec sway
        fi
      '';

      ".zprofile".text = ''
        if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
          exec sway
        fi
      '';

      ".config/sway/brightness.sh".source = ./brightness.sh;
    };
  };
}
