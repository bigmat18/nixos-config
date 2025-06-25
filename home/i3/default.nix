{ config, pkgs, lib, ...}:

with lib;

let
  modifier = "Mod4";
  refresh_i3status = "killall -SIGUSR1 i3status";

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

in
{
  options = {
    services.i3.startupCommands = mkOption {
      type = types.listOf (types.submodule {
        options = {
          command = mkOption {
            type = types.str;
          };
          always = mkOption {
            type = types.bool;
            default = false;
          };
          notification = mkOption {
            type = types.bool;
            default = false;
          };
        };
      });
      default = [ ];
      description = "List of commands to run on startup";
    };
  };

  config = {
    home.packages = with pkgs; [
      alacritty
      flameshot
      feh
    ];

    xsession = {
      enable = true;

      windowManager.i3 = {
        enable = true;

        extraConfig = ''
          for_window [class="FloatingRanger"] floating enable
          for_window [class="ScratchpadFirefox"] move scratchpad
        '';
        # for_window [class="firefox" title="T3 Chat Explanation - T3 Chat — Mozilla Firefox"] floating enable, resize set 1400 1000, move position center

        config = {
          inherit modifier;
          floating.modifier = modifier;
          floating.border = 2;
          fonts = {
            size = 12.0;
          };

          keybindings = {
            "${modifier}+Return"  = "exec alacritty";
            "${modifier}+z"       = "exec sh -c '/home/bigmat18/3rdparty/boomer/boomer | default'";
            "${modifier}+Shift+s" = "exec flameshot gui -r | xclip -selection clipboard -t image/png";
            "${modifier}+Shift+q" = "kill";
            "${modifier}+d"       = "exec rofi -show drun";
            "${modifier}+c"       = "exec rofi -show calc -modi calc -no-show-match -no-sort";
            "${modifier}+Shift+f" = "exec --no-startup-id alacritty --class FloatingRanger -e ranger";

            "${modifier}+Shift+c" = "reload";
            "${modifier}+Shift+r" = "restart";
            "${modifier}+Shift+e" = "exec i3-nagbar -t warning -m 'Do you really want to exit i3?' -B 'Yes, exit' 'i3-msg exit'";

            "XF86AudioRaiseVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +10% && ${refresh_i3status}";
            "XF86AudioLowerVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -10% && ${refresh_i3status}";
            "XF86AudioMute"        = "exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle && ${refresh_i3status}";
            "XF86AudioMicMute"     = "exec --no-startup-id pactl set-source-mute @DEFAULT_SOURCE@ toggle && ${refresh_i3status}";

            "XF86MonBrightnessUp"  = "exec brightnessctl set +10%";
            "XF86MonBrightnessDown" = "exec brightnessctl set 10%-";

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

            # change focus
            "${modifier}+j" = "focus up";
            "${modifier}+k" = "focus down";
            "${modifier}+l" = "focus right";
            "${modifier}+h" = "focus left";

            # alternatively, you can use the cursor keys:
            "${modifier}+Left" = "focus left";
            "${modifier}+Down" = "focus down";
            "${modifier}+Up" = "focus up";
            "${modifier}+Right" = "focus right";

            # move focused window
            "${modifier}+Shift+j" = "move up";
            "${modifier}+Shift+k" = "move down";
            "${modifier}+Shift+l" = "move right";
            "${modifier}+Shift+h" = "move left";

            # alternatively, you can use the cursor keys:
            "${modifier}+Shift+Left" = "move left";
            "${modifier}+Shift+Down" = "move down";
            "${modifier}+Shift+Up" = "move up";
            "${modifier}+Shift+Right" = "move right";

            # split in horizontal orientation
            "${modifier}+b" = "split h";

            # split in vertical orientation
            "${modifier}+v" = "split v";

            # enter fullscreen mode for the focused container
            "${modifier}+f" = "fullscreen toggle";

            # change container layout (stacked, tabbed, toggle split)
            "${modifier}+s" = "layout stacking";
            "${modifier}+w" = "layout tabbed";
            "${modifier}+e" = "layout toggle split";

            # toggle tiling / floating
            "${modifier}+Shift+space" = "floating toggle";

            # change focus between tiling / floating windows
            "${modifier}+space" = "focus mode_toggle";

            # focus the parent container
            "${modifier}+a" = "focus parent";

            "${modifier}+r" = "mode resize";

            "${modifier}+bar" = "move scratchpad";
            "${modifier}+apostrophe" = "scratchpad show";
          };

          modes.resize = {
            "Right" = "resize grow width 5 px or 5 ppt";
            "Up" = "resize shrink height 5 px or 5 ppt";
            "Down" = "resize grow height 5 px or 5 ppt";
            "Left" = "resize shrink width 5 px or 5 ppt";
            "Escape" = "mode default";
            "Return" = "mode default";
          };

          gaps.inner = 8;
          window.border = 2;
          window.titlebar = false;

          colors = {
            focused = {
              text = gruvboxColors.fg;
              background = gruvboxColors.yellow;  # Giallo per focus
              border = gruvboxColors.yellow;      # Giallo per il bordo
              childBorder = gruvboxColors.yellow; # Giallo per il bordo dei figli
              indicator = gruvboxColors.yellow;   # Giallo per l'indicatore
            };

            focusedInactive = {
              text = gruvboxColors.fg;
              background = gruvboxColors.yellow;  # Giallo per focus inattivo
              border = gruvboxColors.yellow;      # Giallo per il bordo
              childBorder = gruvboxColors.yellow; # Giallo per il bordo dei figli
              indicator = gruvboxColors.yellow;   # Giallo per l'indicatore
            };

            unfocused = {
              text = gruvboxColors.fg;
              background = gruvboxColors.bg_inactive;
              border = gruvboxColors.bg_inactive;
              childBorder = gruvboxColors.bg_inactive;
              indicator = gruvboxColors.bg_inactive;
            };

            urgent = {
              text = gruvboxColors.fg;
              background = gruvboxColors.red;  # Rosso per urgenza
              border = gruvboxColors.red;      # Rosso per il bordo
              childBorder = gruvboxColors.red; # Rosso per il bordo dei figli
              indicator = gruvboxColors.red;   # Rosso per l'indicatore
            };
          };

          bars = [];

          startup = [
            {
              command = "dex --autostart --environment i3";
              always = false;
              notification = false;
            }
            {
              command = "rclone mount iclouddrive: ~/icloud/ --vfs-cache-mode full";
              always = false;
              notification = false;
            }
            {
              command = "picom";
              always = false;
              notification = false;
            }
            {
              command = "blueman-applet";
              always = false;
              notification = false;
            }
            {
              command = "feh --no-fehbg --bg-scale ~/.config/background.jpeg --bg-scale ~/.config/background.jpeg";
              always = true;
              notification = false;
            }
            #{
              #command = "firefox --class \"ScratchpadFirefox\" --new-window \"https://calendar.google.com\"";
              #always = true;
              #notification = false;
            #}
          ] ++ config.services.i3.startupCommands;
        };
      };
    };
    home.file.".config/background.jpeg".source = ../../background/ign_astronaut.png;
  };
}
