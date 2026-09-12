{
  config,
  pkgs,
  lib,
  vars,
  ...
}:

with lib;

let
  modifier = "SUPER";
in
{
  home.packages = with pkgs; [
    # Screenshots tools
    grim
    slurp

    # Brightness tools
    jq
    wl-gammarelay-rs
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    configType = "hyprlang";

    settings = {
      monitor = [
        "DP-1, 2560x1440@180, 0x0, 1, transform, 2"
        "HDMI-A-1, 1920x1080@60, 2560x0, 0.83, transform, 2"
      ];

      input = {
        kb_layout = "us";
        kb_variant = "intl";
        kb_options = "compose:ralt";
      };

      "$mod" = modifier;

      general = {
        gaps_in = 6;
        gaps_out = 6;
        border_size = 2;
        layout = "dwindle";
      };

      decoration = {
        rounding = 0;

        shadow = {
          enabled = true;
          range = 15;
          render_power = 3;
        };

        blur = {
          enabled = true;
          size = 7;
          passes = 3;
          new_optimizations = true;
          ignore_opacity = true;
        };
      };

      workspace = [
        "1, monitor:DP-1, default:true"
      ];

      env = [
        "XCURSOR_THEME,Adwaita"
        "XCURSOR_SIZE,24"
      ];

      animations.enabled = false;

      exec-once = [
        "hyprctl setcursor Adwaita 24"
        "xrandr --output DP-1 --primary"
        "dex --autostart --environment hyprland"
        "dunst"
        "waybar"
        "blueman-applet"
      ];

      windowrule = [
        "float 1, match:class ^(Floating)$"
        "size 1200 600, match:class ^(Floating)$"
        "center 1, match:class ^(Floating)$"
      ];

      bind = [
        "$mod, Return, exec, alacritty"
        "$mod SHIFT, Return, exec, alacritty -e distrobox-enter --root debian-box"
        "$mod SHIFT, s, exec, grim -g \"$(slurp)\" - | wl-copy -t image/png"

        "$mod SHIFT, q, killactive,"
        "$mod, d, exec, rofi -show drun"
        "$mod, b, exec, firefox"
        "$mod, c, exec, rofi -show calc -modi calc -no-show-match -no-sort"
        "$mod SHIFT, f, exec, alacritty --class Floating -e yazi"

        "$mod SHIFT, c, exec, hyprctl reload"
        "$mod SHIFT, r, exec, hyprctl reload"
        "$mod SHIFT, e, exit,"

        ", XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +10%"
        ", XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -10%"
        ", XF86AudioMute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle"
        ", XF86AudioMicMute, exec, pactl set-source-mute @DEFAULT_SOURCE@ toggle"

        ", XF86MonBrightnessUp, exec, bash ~/.config/hypr/brightness.sh +"
        ", XF86MonBrightnessDown, exec, bash ~/.config/hypr/brightness.sh -"

        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"

        "$mod, j, movefocus, u"
        "$mod, k, movefocus, d"
        "$mod, l, movefocus, r"
        "$mod, h, movefocus, l"

        "$mod, Left, movefocus, l"
        "$mod, Down, movefocus, d"
        "$mod, Up, movefocus, u"
        "$mod, Right, movefocus, r"

        "$mod SHIFT, j, movewindow, u"
        "$mod SHIFT, k, movewindow, d"
        "$mod SHIFT, l, movewindow, r"
        "$mod SHIFT, h, movewindow, l"

        "$mod SHIFT, Left, movewindow, l"
        "$mod SHIFT, Down, movewindow, d"
        "$mod SHIFT, Up, movewindow, u"
        "$mod SHIFT, Right, movewindow, r"

        "$mod, f, fullscreen,"
        "$mod SHIFT, space, exec, hyprctl dispatch togglefloating && hyprctl activewindow | grep -q 'floating: 1' && hyprctl dispatch resizeactive exact 75% 75% && hyprctl dispatch centerwindow"

        "$mod, e, layoutmsg, togglesplit,"
        "$mod, n, exec, hyprctl dispatch layoutmsg preselect r"
        "$mod, v, exec, hyprctl dispatch layoutmsg preselect d"

        "$mod, minus, movetoworkspace, special:scratchpad"
        "$mod, p, togglespecialworkspace, scratchpad"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
    };

    extraConfig = ''
      bind = $mod, r, submap, resize
      submap = resize

      binde = , Right, resizeactive, 10 0
      binde = , Left, resizeactive, -10 0
      binde = , Up, resizeactive, 0 -10
      binde = , Down, resizeactive, 0 10

      bind = , Escape, submap, reset
      bind = , Return, submap, reset

      submap = reset
    '';
  };

  home.file.".config/hypr/brightness.sh".source = ./brightness.sh;
}
