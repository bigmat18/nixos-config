{ config, pkgs, username, ... }:

{
  home.packages = [ pkgs.git ];

  programs.git = {
    enable = true;

    settings = {
      user.name  = "${username}";
      user.email = "mat.giu2002@gmail.com";

      alias = {
        co = "checkout";
        br = "branch";
        ci = "commit";
        st = "status";
        lg = "log --oneline --graph --all";
      };

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