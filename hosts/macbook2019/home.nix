{ config, pkgs, ... }:

{
  home.username = "bigmat18";
  home.homeDirectory = "/home/bigmat18";

  home.stateVersion = "24.11"; # Please read the comment before changing.

  home.packages = [
  ];

  home.file = {
    ".config/i3/config".source = ../../dotfiles/i3/config;
    ".xinitrc".source = ../../dotfiles/.xinitrc;
    ".bash_profile".source = ../../dotfiles/.bash_profile;
  };

  home.sessionVariables = {
    EDITOR = "vim";
  };

  programs.home-manager.enable = true;

  services.picom = {
        enable = true;
        backend = "glx";
        settings = {
          blur = false;
          blurExclude = [ ];
          inactiveDim = "0.05";
          noDNDShadow = false;
          noDockShadow = false;
          # shadow-radius = 20
          # '';
          # shadow-radius = 20
          # corner-radius = 10
          # blur-size = 20
          # rounded-corners-exclude = [
          # "window_type = 'dock'",
          # "class_g = 'i3-frame'"
          # ]
          # '';
        };
        fade = false;
        inactiveOpacity = 1.0;
        menuOpacity = 1.0;
        opacityRules = [
          "0:_NET_WM_STATE@[0]:32a = '_NET_WM_STATE_HIDDEN'" # Hide tabbed windows
        ];
        shadow = false;
        shadowExclude = [ ];
        shadowOffsets = [
          (-10)
          (-10)
        ];
        shadowOpacity = 0.5;
        vSync = true;
      };

      xsession.windowManager.i3.config.startup = [
        {
          command = "systemctl --user restart picom";
          always = true;
          notification = false;
        }
      ];

}