{ config, lib, pkgs, vars, ... }:

let
  cfg = config.custom.wayland;
in
{
  options.custom.wayland = {
    compositor = lib.mkOption {
      type = lib.types.enum [ "sway" "hyprland" ];
      default = "sway";
    };
  };

  config = {
    programs.sway = lib.mkIf (cfg.compositor == "sway") {
      enable = true;
      wrapperFeatures.gtk = true;
    };

    programs.hyprland = lib.mkIf (cfg.compositor == "hyprland") {
      enable = true;
      xwayland.enable = true;
    };

    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd '${
            if cfg.compositor == "sway" then "sway --unsupported-gpu" else "start-hyprland"
          }'";
          user = "${vars.username}";
        };
      };
    };

    environment.sessionVariables = lib.mkMerge [
      {
        NIXOS_OZONE_WL = "1";
        WLR_NO_HARDWARE_CURSORS = "1";
        MOZ_ENABLE_WAYLAND = "1";
      }
    ];

    environment.systemPackages = with pkgs; [
      tuigreet
      wl-clipboard
      wlr-randr
      adwaita-icon-theme
      xrandr
    ];
  };
}
