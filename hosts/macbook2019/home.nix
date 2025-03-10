{ config, pkgs, ... }:

{
  home.username = "bigmat18";
  home.homeDirectory = "/home/bigmat18";

  home.stateVersion = "24.11"; # Please read the comment before changing.

  home.packages = [
  ];

  home.file = {
    ".config/i3/config".source = ../../dotfiles/i3/config;
    ".config/i3status/config".source = ../../dotfiles/i3status/config;
    ".xinitrc".source = ../../dotfiles/.xinitrc;
    ".bash_profile".source = ../../dotfiles/.bash_profile;
    ".config/nitrogen/bg-saved.cfg".source = ../../dotfiles/nitrogen/bg-saved.cfg;
    ".config/nitrogen/bg.png".source = ../../dotfiles/nitrogen/bg.png;
    ".config/rclone/rclone.conf".source = ../../dotfiles/rclone/rclone.conf;
  };

  home.sessionVariables = {
    EDITOR = "vim";
  };

  programs.home-manager.enable = true;

  services.picom = {
    enable = true;
    backend = "glx";
    opacityRules = [
      "80:class_g = 'Alacritty'"
    ];
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