{ config, pkgs, lib, ...}:

with lib;

let
  modifier = "Mod4";
  refresh_i3status = "killall -SIGUSR1 i3status";
  bg_color = "#282828";
  inactive_bg = "#3c3836";
  text_color = "#ebdbb2";
  focus_bg = "#d79921";
  urgent_bg = "#cc241d";
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
      i3status
      rofi
      alacritty
      flameshot
      feh
    ];

    xsession = {
      enable = true;

      windowManager.i3 = {
        enable = true;

        config = {
          inherit modifier;
          floating.modifier = modifier;
          floating.border = 2;
          fonts = {
            size = 12.0;
          };

          keybindings = {
            "${modifier}+Return"  = "exec alacritty";
            # "${modifier}+Shift+s" = "exec flameshot gui";
            "${modifier}+Shift+s" = "exec flameshot gui -r | xclip -selection clipboard -t image/png";
            "${modifier}+Shift+q" = "kill";
            "${modifier}+d"       = "exec rofi -show drun";
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
            "${modifier}+j" = "focus left";
            "${modifier}+k" = "focus down";
            "${modifier}+l" = "focus up";
            "${modifier}+ograve" = "focus right";

            # alternatively, you can use the cursor keys:
            "${modifier}+Left" = "focus left";
            "${modifier}+Down" = "focus down";
            "${modifier}+Up" = "focus up";
            "${modifier}+Right" = "focus right";

            # move focused window
            "${modifier}+Shift+j" = "move left";
            "${modifier}+Shift+k" = "move down";
            "${modifier}+Shift+l" = "move up";
            "${modifier}+Shift+ograve" = "move right";

            # alternatively, you can use the cursor keys:
            "${modifier}+Shift+Left" = "move left";
            "${modifier}+Shift+Down" = "move down";
            "${modifier}+Shift+Up" = "move up";
            "${modifier}+Shift+Right" = "move right";

            # split in horizontal orientation
            "${modifier}+h" = "split h";

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
              text = text_color; 
              background = focus_bg;
              border = focus_bg;
              childBorder = focus_bg;
              indicator = focus_bg;
            };

            focusedInactive = {
              text = text_color; 
              background = focus_bg; 
              border = focus_bg;
              childBorder = focus_bg;
              indicator = focus_bg;
            };

            unfocused = {
              text = text_color;
              background = inactive_bg;
              border = inactive_bg;
              childBorder = inactive_bg;
              indicator = inactive_bg;
            };

            urgent = {
              text = text_color;
              background = urgent_bg;
              border = urgent_bg;
              childBorder = urgent_bg;
              indicator = urgent_bg;
            };
          };

          bars = [
            # {
            #   statusCommand = "i3status";
            #   position = "top";
            #   fonts = {
            #     names = ["DejaVu Sans Mono"];
            #     size = 12.0;
            #   };

            #   colors = {
            #     background = bg_color;
            #     statusline = text_color;
            #     separator = "#928374";

            #     focusedWorkspace = {
            #       border = focus_bg;
            #       background = bg_color;
            #       text = focus_bg;
            #     };

            #     activeWorkspace = {
            #       border = "#a89984";
            #       background = bg_color;
            #       text = "#a89984";
            #     };

            #     inactiveWorkspace = {
            #       border = "#928374";
            #       background = bg_color;
            #       text = "#928374";
            #     };

            #     urgentWorkspace = {
            #       border = urgent_bg;
            #       background = bg_color;
            #       text = urgent_bg;
            #     };
            #   };

            #   extraConfig = ''
            #     padding 3px 0
            #     workspace_min_width 50
            #     separator_symbol " "
            #   '';

            #   trayOutput = "primary";
            #   trayPadding = 5;
            # }
          ];

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
              command = "feh --no-fehbg --bg-scale ~/.config/background.jpeg --bg-scale ~/.config/background.jpeg";
              always = true;
              notification = false;
            }
          ] ++ config.services.i3.startupCommands;
        };
      };
    };
    home.file.".config/background.jpeg".source = ../../background/Chris-Bumstead.jpeg;
  };
}