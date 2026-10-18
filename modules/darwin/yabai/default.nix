{ pkgs, ... }:

let
  mod = "alt";
in
{
  services.yabai = {
    enable = true;
    enableScriptingAddition = false;

    config = {
      layout = "bsp";
      auto_balance = "on";
      split_ratio = 0.50;
      top_padding = 6;
      bottom_padding = 6;
      left_padding = 6;
      right_padding = 6;
      window_gap = 6;
      window_placement = "second_child";
      focus_follows_mouse = "autoraise";
      mouse_follows_focus = "off";
      mouse_modifier = "cmd";
      mouse_action1 = "move";
      mouse_action2 = "resize";
    };

    extraConfig = ''
      yabai -m rule --add app="^System Settings$" manage=off
      yabai -m rule --add app="^Calculator$" manage=off
      yabai -m rule --add app="^Raycast$" manage=off
      yabai -m rule --add title="^FloatingRanger$" manage=off grid=4:4:1:1:2:2
    '';
  };

  services.skhd = {
    enable = true;
    skhdConfig = ''
      # ==========================================
      # Applicazioni & Utility
      # ==========================================
      ${mod} - return : open -na /Applications/Alacritty.app || alacritty
      ${mod} + shift - s : screencapture -i -c
      ${mod} + shift - q : yabai -m window --close
      ${mod} - d : open -a "Raycast" || open -a "Spotlight"
      ${mod} - b : open -a "Firefox"
      ${mod} - c : open -a "Calculator"
      ${mod} + shift - f : alacritty --title "FloatingRanger" -e yazi

      ${mod} + shift - c : yabai --restart-service && skhd --restart-service
      ${mod} + shift - r : yabai --restart-service && skhd --restart-service

      # ==========================================
      # Focus Navigazione (hjkl + Frecce)
      # ==========================================
      ${mod} - h : yabai -m window --focus west
      ${mod} - j : yabai -m window --focus south
      ${mod} - k : yabai -m window --focus north
      ${mod} - l : yabai -m window --focus east

      ${mod} - left  : yabai -m window --focus west
      ${mod} - down  : yabai -m window --focus south
      ${mod} - up    : yabai -m window --focus north
      ${mod} - right : yabai -m window --focus east

      # ==========================================
      # Sposta Finestre
      # ==========================================
      ${mod} + shift - h : yabai -m window --warp west || yabai -m window --swap west
      ${mod} + shift - j : yabai -m window --warp south || yabai -m window --swap south
      ${mod} + shift - k : yabai -m window --warp north || yabai -m window --swap north
      ${mod} + shift - l : yabai -m window --warp east || yabai -m window --swap east

      ${mod} + shift - left  : yabai -m window --warp west || yabai -m window --swap west
      ${mod} + shift - down  : yabai -m window --warp south || yabai -m window --swap south
      ${mod} + shift - up    : yabai -m window --warp north || yabai -m window --swap north
      ${mod} + shift - right : yabai -m window --warp east || yabai -m window --swap east

      # ==========================================
      # Split & Layout
      # ==========================================
      ${mod} - n : yabai -m window --insert east
      ${mod} - v : yabai -m window --insert south
      ${mod} - f : yabai -m window --toggle zoom-fullscreen
      ${mod} - s : yabai -m space --layout stack
      ${mod} - e : yabai -m space --layout bsp
      ${mod} + shift - space : yabai -m window --toggle float --grid 4:4:1:1:2:2

      # ==========================================
      # Spazi (1 - 9)
      # ==========================================
      ${mod} - 1 : yabai -m space --focus 1
      ${mod} - 2 : yabai -m space --focus 2
      ${mod} - 3 : yabai -m space --focus 3
      ${mod} - 4 : yabai -m space --focus 4
      ${mod} - 5 : yabai -m space --focus 5
      ${mod} - 6 : yabai -m space --focus 6
      ${mod} - 7 : yabai -m space --focus 7
      ${mod} - 8 : yabai -m space --focus 8
      ${mod} - 9 : yabai -m space --focus 9

      ${mod} + shift - 1 : yabai -m window --space 1 && yabai -m space --focus 1
      ${mod} + shift - 2 : yabai -m window --space 2 && yabai -m space --focus 2
      ${mod} + shift - 3 : yabai -m window --space 3 && yabai -m space --focus 3
      ${mod} + shift - 4 : yabai -m window --space 4 && yabai -m space --focus 4
      ${mod} + shift - 5 : yabai -m window --space 5 && yabai -m space --focus 5
      ${mod} + shift - 6 : yabai -m window --space 6 && yabai -m space --focus 6
      ${mod} + shift - 7 : yabai -m window --space 7 && yabai -m space --focus 7
      ${mod} + shift - 8 : yabai -m window --space 8 && yabai -m space --focus 8
      ${mod} + shift - 9 : yabai -m window --space 9 && yabai -m space --focus 9

      ${mod} - p : yabai -m window --toggle minimize

      # ==========================================
      # Modal Resize
      # ==========================================
      :: resize @
      ${mod} - r ; resize

      resize < escape ; default
      resize < return ; default

      resize < left  : yabai -m window --resize left:-20:0 || yabai -m window --resize right:-20:0
      resize < down  : yabai -m window --resize bottom:0:20 || yabai -m window --resize top:0:20
      resize < up    : yabai -m window --resize top:0:-20 || yabai -m window --resize bottom:0:-20
      resize < right : yabai -m window --resize right:20:0 || yabai -m window --resize left:20:0
    '';
  };
}
