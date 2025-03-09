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
    ".config/nitrogen/bg-save.cfg".source = ../../dotfiles/nitrogen/bg-save.cfg;
    ".config/nitrogen/bg.png".source = ../../dotfiles/nitrogen/bg.png;
  };

  home.sessionVariables = {
    EDITOR = "vim";
  };

  programs.home-manager.enable = true;

  services.picom = {
    enable = true;
    backend = "glx";
    opacityRules = [
      "80:class_g = '.*'"
    ];
    activeOpacity = 1;
    inactiveOpacity = 0.5;
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