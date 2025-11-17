{ config, pkgs, username, ... }:

{
  home.packages = [ pkgs.git ];

  programs.git = {
    enable = true;

    userName  = "${username}";
    userEmail = "mat.giu2002@gmail.com";

    aliases = {
      co = "checkout";
      br = "branch";
      ci = "commit";
      st = "status";
      lg = "log --oneline --graph --all";
    };

    extraConfig = {
      core = {
        editor = "nvim";
        autocrlf = "input";
      };
      pull = {
        rebase = true;
      };
      push = {
        default = "simple";
      };
      color = {
        ui = "auto";
      };
    };
  };
}